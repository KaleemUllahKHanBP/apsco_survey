import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart';
import 'package:path/path.dart' as path;
import 'package:survey/screen/dashboard/main_dashboard.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';

import '../../../db_helper/db_helper.dart';
import '../../../networks_api/http_manager.dart';
import '../../../res/routes/routes.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/services/image_tacking_services.dart';
import '../../../utils/services/take_image_and_save_to_folder.dart';
import '../../../utils/utils.dart';
import '../model/apsco_saving_model.dart';
import '../model/epsco_question_list_model.dart';
import '../model/image_model_class_for_gcs.dart';
import '../model/sys_survey_question_option_model.dart';
class ApscoSurveyController extends GetxController {

  RxInt currentIndex = 0.obs;
  RxMap<int, dynamic> answersRadio = <int, dynamic>{}.obs;
  RxList<File> imagesList =<File>[].obs;
  RxList<File> allImagesList =<File>[].obs;
  RxList<String> imagesNameList =<String>[].obs;
  RxString userName = "".obs;
  RxString storeId = "".obs;
  RxString storeName = "".obs;
  RxBool isImageLoading = false.obs;
  RxBool isButtonLoading = false.obs;
  RxBool isDataLoading = true.obs;
  RxBool isApscoSurveyFinishLoading = false.obs;
  final valueControllerComment = TextEditingController().obs;

  RxList<EpscoSurveyListData> surveyQuestions = <EpscoSurveyListData>[].obs;

  List<TransGcsImagesListModel> apscoSurveyImagesDataList = [];
  List<TransGcsImagesListModel> apscoSurveyGcsImagesList=[];
  List<ApscoSurveyRequestData> apscoSurveyRequestData=[];

  List<File> imageFiles = [];

  RxList<String> answerOptionList = <String>[].obs;

  List<sysSurveyQuestionOptionModel> surveyOptions = <sysSurveyQuestionOptionModel>[
    sysSurveyQuestionOptionModel(
      id: 0,
      questionId: 0,
      en_name: "Yes",
      ar_name: "نعم",
      answer_type: "radio",
    ),
    sysSurveyQuestionOptionModel(
      id: 0,
      questionId: 0,
      en_name: "No",
      ar_name: "لا",
      answer_type: "radio",
    ),

  ];

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
  Future<void> getUserData() async {
     userName.value = (await PrefUtils.instance.getString(AppConstants.userId))!;
    storeId.value = (await PrefUtils.instance.getString(AppConstants.storeId))!;
    storeName.value = (await PrefUtils.instance.getString(AppConstants.storeName))!;
    getGtcSurveyQuestion();


  }

  getGtcSurveyQuestion() async {
    isDataLoading.value = true;
    await DatabaseHelper.getGtcSurveyDataList().then((value) async {
      surveyQuestions.value = value.cast<EpscoSurveyListData>();
      print("++++++++++++++++++++++++++++++++");
      print(jsonEncode(surveyQuestions));
      getTransSadafcoSurveyItemData();
      isDataLoading.value = false;
    });
  }

  Future<void> getImage(int questionId) async {
    isImageLoading.value = true;
    await ImageTakingService.imageSelect().then((value) {
      if (value == null) {
        isImageLoading.value= false;
        return;
      }
      print(value.path);
      imagesList.remove(value);
      imagesList.add(value);
      final String extension = path.extension(value.path);
      imagesNameList.add("${userName}_${questionId}_${DateTime.now().millisecondsSinceEpoch}$extension");
      surveyQuestions[currentIndex.value].gcsStatus = 0;
      print("Check image list data ========");
      print(imagesNameList);
      isImageLoading.value= false;
    });
  }
  void deleteImage(int indexToDelete) {
    print("Check image index=========== $indexToDelete");
    imagesList.removeAt(indexToDelete);
    imagesNameList.removeAt(indexToDelete);
  }



  Future<void> nextSurvey(BuildContext context) async {
    // imagesNameList.clear();
    // imagesList.clear();

    String answerText = "";
    String selectedAnswerOption = "";
    String imagesName = "";
    if (surveyQuestions[currentIndex.value].sysSurveyAnswerType == "radio") {
      if (answersRadio[currentIndex.value] == null ||
          answersRadio[currentIndex.value] == "") {
        Utils.showSnackBar("Please Select options", SnackType.error);
        return;
      }
      if (answersRadio[currentIndex.value] == "Yes") {
        if (surveyQuestions[currentIndex.value].sysOnYesGetValue == "number" ||
            surveyQuestions[currentIndex.value].sysOnYesGetValue == "text") {
          if(valueControllerComment.value.text.isEmpty) {
          Utils.showSnackBar("Please Add value in field", SnackType.error);
          return;
          } else {
            answerText = valueControllerComment.value.text;
          }
        }
        if(surveyQuestions[currentIndex.value].sysOnYesGetImage == "Y") {
          if (imagesList.isNotEmpty && imagesNameList.isNotEmpty &&
              imagesNameList.length == imagesList.length) {
            imagesName = imagesNameList.join(',');
            print("Check image list name");
            print(imagesName);
          } else {
            Utils.showSnackBar(
                "Please take at least one image", SnackType.error);
            return;
          }
        }
      }
      selectedAnswerOption = answersRadio[currentIndex.value];
    }
    else if(surveyQuestions[currentIndex.value].sysSurveyAnswerType == "number" || surveyQuestions[currentIndex.value].sysSurveyAnswerType == "text") {
      if (valueControllerComment.value.text.isEmpty) {
        Utils.showSnackBar(
            "Please add value in text field", SnackType.error);
        return;
      } else {
        answerText = valueControllerComment.value.text;
      }

      if(surveyQuestions[currentIndex.value].sysOnYesGetImage == "Y") {
        print(imagesNameList.length);
        print(imagesList.length);
        if (imagesList.isNotEmpty &&
            imagesNameList.isNotEmpty &&
            imagesNameList.length == imagesList.length) {
          imagesName = imagesNameList.join(',');
        }
      }
    } else if(surveyQuestions[currentIndex.value].sysSurveyAnswerType == "image") {
      print("----------------- Current Values -------------------");
      print(currentIndex);
      print(surveyQuestions[currentIndex.value].sysSurveyAnswerType);
      print(answersRadio[currentIndex.value]);
      print("------------------------------------------------------");
      if (imagesList.isNotEmpty && imagesNameList.isNotEmpty &&
          imagesNameList.length == imagesList.length) {
        imagesName = imagesNameList.join(',');
      } else {
        // showAnimatedToastMessage(
        //     "Error".tr, "Please take at least one image".tr, false);
        return;
      }
    }



    print(answerText);
    print(selectedAnswerOption);
    print(imagesName);

    // if (currentIndex.value < surveyQuestions.length - 1) {
    //   currentIndex.value++;
    // }

    await insertGtcSurveyAnswer(surveyQuestions[currentIndex.value].id,answerText,selectedAnswerOption,imagesName,context);
  }

  insertGtcSurveyAnswer(int questionId,String answerText,String selectedAnswerOption,String imageNames,BuildContext context) async {
    await DatabaseHelper.updateGtcSurveyItem(questionId.toString(), surveyQuestions[currentIndex.value].gcsStatus,selectedAnswerOption,answerText,imageNames)
        .then((value) async {
      for(int i=0; i<imagesList.length; i++) {
        print(imagesList[i].path);
        RxString dirPath = "".obs;
        if(Platform.isAndroid){
          dirPath.value = (await getExternalStorageDirectory())!.path;
        } else if(Platform.isIOS){
          dirPath.value = (await getApplicationDocumentsDirectory()).path;
        }

        final String folderPath = '${dirPath.value}/cstore/$userName/${AppConstants.epscoSurvey}';
        final String filePath = '$folderPath/${imagesNameList[i]}';
        print(filePath);
        bool isFileExist = await fileExists(filePath);
        if(isFileExist) {
          print("FIleExist");
        } else {
          print("File does not exist");
          await takePicture(context, imagesList[i], imagesNameList[i],userName.value,AppConstants.epscoSurvey).then((value) => {
            if (currentIndex.value == surveyQuestions.length)
            isButtonLoading.value = false,
         //ToastMessage.succesMessage(context, "Data Saved Successfully".tr),
          }).catchError((e) => {
           // ToastMessage.errorMessage(context, e.toString()),
            isButtonLoading.value = false,
          });
        }
      }
      imagesNameList.clear();
      imagesList.clear();
      valueControllerComment.value.clear();
      if (currentIndex < surveyQuestions.length - 1) {
        currentIndex++;

        getTransSadafcoSurveyItemData();
      } else {
        finishVisit();
      }

      isButtonLoading.value = false;
    }).catchError((e) {
      print(e.toString());
     // ToastMessage.errorMessage(context, e.toString());
    });
  }

  Future<void> getTransSadafcoSurveyItemData() async {
    EpscoSurveyListData gtcSurveyListData = EpscoSurveyListData(
      id: 0,
      sysSurveyEnQuestion:  "",
      sysSurveyArQuestion:  "",
      sysOnYesGetImage:  "",
      sysOnYesGetValue:  "",
      sysSurveyAnswerType:  "",
      transFirstAnswer:  "",
      transSecondAnswer:  "",
      transImageName:  "",
      uploadStatus: 0,
      gcsStatus:  0,
      skuImage: '',
    );

    imagesNameList.clear();
    imagesList.clear();
    valueControllerComment.value.clear();
    isButtonLoading.value = true;
    await DatabaseHelper.getEpscoSurveySingleQuestionData(surveyQuestions[currentIndex.value].id).then((value) async {
      gtcSurveyListData = value;

      if(gtcSurveyListData.transFirstAnswer != "") {
        answersRadio[currentIndex.value] = gtcSurveyListData.transFirstAnswer;
      }

      valueControllerComment.value.text = gtcSurveyListData.transSecondAnswer;

      if(gtcSurveyListData.transImageName.isEmpty || gtcSurveyListData.transImageName == "") {
        imagesNameList.value = [];
        imagesList.value = [];
      } else {
        imagesNameList.value = gtcSurveyListData.transImageName.split(",");
      }

      await _loadImages().then((value) async {
        await setTransPhoto();
      });

      answersRadio.refresh();
      surveyQuestions.refresh();

    }).catchError((e) {
      print(e.toString());
      isButtonLoading.value = false;
    });

  }
  void previousSurvey() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      getTransSadafcoSurveyItemData();
    }
  }


  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      print('Error checking file existence: $e');
      return false;
    }
  }

  Future<void> _loadImages() async {
    isButtonLoading.value = true;
    try {

      RxString dirPath = "".obs;
      if(Platform.isAndroid){
        dirPath.value = (await getExternalStorageDirectory())!.path;
      } else if(Platform.isIOS){
        dirPath.value = (await getApplicationDocumentsDirectory()).path;
      }

      final String folderPath =
          '${dirPath.value}/cstore/$userName/${AppConstants.epscoSurvey}';
      print("******************");
      print(folderPath);
      final Directory folder = Directory(folderPath);
      if (await folder.exists()) {
        final List<FileSystemEntity> files = folder.listSync();
        allImagesList.value = files.whereType<File>().toList();
      }
    } catch (e) {
      print('Error reading images: $e');
    }
  }

  Future<void> setTransPhoto() async {
    List<File> imagesTaken = [];
    for (int i = 0; i<imagesNameList.length; i++) {

      for (int j = 0; j < allImagesList.length; j++) {

        if (allImagesList[j].path.endsWith(imagesNameList[i])) {
          imagesTaken.add(allImagesList[j]);
        }
      }

    }
    imagesList.value = imagesTaken;

    print("Taken Images List");
    print(imagesNameList);
    print(imagesList);
    print(allImagesList);

    isButtonLoading.value = false;
  }

  void selectRadio(int index, String value) {
    answersRadio[index] = value;
    print("RadioButton");
    print(answersRadio[index]);
    refresh();
  }

  finishVisit() async {
    isApscoSurveyFinishLoading.value = true;
    final credentials = ServiceAccountCredentials.fromJson(
      await rootBundle.loadString(
          'assets/google_cloud_creds/appimages-keycstoreapp-7c0f4-a6d4c3e5b590.json'),
    );

    final httpClient = await clientViaServiceAccount(credentials, [StorageApi.devstorageReadWriteScope]);

    // Create a Storage client with the credentials
    final storage = StorageApi(httpClient);

    await DatabaseHelper.getApscoSurveyGcsImagesList().then((value) async {

      apscoSurveyGcsImagesList = value.cast<TransGcsImagesListModel>();

      await getImages().then((value) {
        setApscoTransFinish();
      });
      isApscoSurveyFinishLoading.value = false;
    });

    isApscoSurveyFinishLoading.value = true;

    print("------ Apsco Survey Image Upload -------- ");
    for(int j = 0; j < apscoSurveyImagesDataList.length; j++) {

      if(apscoSurveyImagesDataList[j].imageFile != null) {

        bool isCorruptImage = await isImageCorrupted(XFile(apscoSurveyImagesDataList[j].imageFile!.path));
        if(isCorruptImage) {
          await updateApcsoSurveyAfterGcs1(apscoSurveyImagesDataList[j].id);
        } else {

          final filename =  apscoSurveyImagesDataList[j].imageName;
          final filePath = 'apsco_survey_photo/$filename';
          final fileContent = await apscoSurveyImagesDataList[j].imageFile!.readAsBytes();
          final bucketObject = Object(name: filePath);

          await storage.objects.insert(
            bucketObject,
            "cstore-bucket",
            predefinedAcl: 'publicRead',
            uploadMedia: Media(
              Stream<List<int>>.fromIterable([fileContent]),
              fileContent.length,
            ),
          );
          print("Image Uploaded successfully");

          await updateApcsoSurveyAfterGcs1(apscoSurveyImagesDataList[j].id);

        }
      } else {
        await updateApcsoSurveyAfterGcs1(apscoSurveyImagesDataList[j].id);
      }

    }

    isApscoSurveyFinishLoading.value = false;

    saveApscoSurvey();
  }

  Future<bool> updateApcsoSurveyAfterGcs1(int surveyQuestionId) async {
    print("UPLOAD GTC SURVEY AFTER GCS");
    await DatabaseHelper.updateApcsoSurveyAfterGcsAfterFinish(surveyQuestionId).then((value) {

    });

    return true;
  }


  saveApscoSurvey() async {

    await DatabaseHelper.getActivityStatusApscoSurveyDataList().then((value) async {

      apscoSurveyRequestData = value.cast<ApscoSurveyRequestData>();

    });

    ApscoSurveyRequest apscoSurveyRequest = ApscoSurveyRequest(
      storeId: storeId.value,
      surveyList: apscoSurveyRequestData,
    );

    print("************ Apsco Survey Upload in Api **********************");
    print(jsonEncode(apscoSurveyRequest));

    isApscoSurveyFinishLoading.value = true;

    HTTPManager()
        .saveSurveyData(apscoSurveyRequest)
        .then((value) async => {
      print("************ Apsco Survey Values **********************"),

      await updateTransApscoSurveyAfterApi(),
      isApscoSurveyFinishLoading.value  = false,
        Get.offNamed(Routes.mainDashboard),
       Utils.showSnackBar("Your Survey is uploaded successfully", SnackType.success),



      // ToastMessage.succesMessage(context, "Planoguide Data Uploaded Successfully".tr),
    }).catchError((onError)=>{
      Utils.showSnackBar(onError.toString(), SnackType.error),
      print(onError.toString()),

      isApscoSurveyFinishLoading.value = false,
    });

  }

  Future<bool> updateTransApscoSurveyAfterApi() async {
    String ids = "";
    for(int i=0;i<apscoSurveyRequestData.length;i++) {
      ids = "${apscoSurveyRequestData[i].questionId.toString()},$ids";
    }
    ids = removeLastComma(ids);
    print(ids);
    await DatabaseHelper.updateApscoSurveyAfterApi(ids).then((value) {

    });

    return true;
  }

  String removeLastComma(String input) {
    if (input.endsWith(',')) {
      return input.substring(0, input.length - 1);
    }
    return input;
  }

  Future<void> getImages() async {
    try {
      RxString dirPath = "".obs;
      if(Platform.isAndroid){
        dirPath.value = (await getExternalStorageDirectory())!.path;
      } else if(Platform.isIOS){
        dirPath.value = (await getApplicationDocumentsDirectory()).path;
      }

      final String folderPath = '${dirPath.value}/cstore/$userName/${AppConstants.epscoSurvey}';
      print(folderPath);
      final Directory folder = Directory(folderPath);
      // print(folderPath);
      if (await folder.exists()) {
        final List<FileSystemEntity> files = folder.listSync();
        imageFiles = files.whereType<File>().toList();
        // print("****************** $module");
        // print(_imageFiles);
      } else {
        print("Folder does not exist");
      }
    } catch (e) {
      print('Error reading images: $e');
    }
  }

  setApscoTransFinish() {
    apscoSurveyImagesDataList.clear();

    for(int i = 0; i<apscoSurveyGcsImagesList.length; i++) {
      List surveyImages = apscoSurveyGcsImagesList[i].imageName.split(",");

      for(int j = 0; j < surveyImages.length; j++) {
        apscoSurveyImagesDataList.add(TransGcsImagesListModel(id: apscoSurveyGcsImagesList[i].id, imageFile: null, imageName: surveyImages[j]));
      }
    }

    for (int j=0;j<apscoSurveyImagesDataList.length; j++) {
      for (int i = 0; i < imageFiles.length; i++) {
        if(apscoSurveyImagesDataList[j].imageName.isNotEmpty)
        {
          if (imageFiles[i].path.endsWith(apscoSurveyImagesDataList[j].imageName)) {
            apscoSurveyImagesDataList[j].imageFile = imageFiles[i];
          }
        }
      }

      print("-------------------------");
      print(apscoSurveyImagesDataList[j].id);
      print(apscoSurveyImagesDataList[j].imageName);
      print(apscoSurveyImagesDataList[j].imageFile);
      print("-------------------------");

    }
  }

}