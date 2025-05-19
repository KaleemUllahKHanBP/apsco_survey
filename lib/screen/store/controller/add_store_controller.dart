import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:survey/db_helper/db_helper.dart';
import 'package:survey/screen/store/model/add_store_model.dart';
import 'package:survey/utils/app_constants.dart';
import 'package:survey/utils/dialog/alert_dialog.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';
import 'package:survey/utils/utils.dart';
import '../../../db_helper/db_constant.dart';
import '../../../networks_api/http_manager.dart';
import 'package:path/path.dart' as path;
import '../../../utils/services/image_tacking_services.dart';
import '../../../utils/services/location_services.dart';
import '../model/city_list_model.dart';

class AddStoreController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isRegionLoading = false.obs;
  final RxBool isCityLoading = false.obs;
  final RxString currentLocation = "".obs;
  final RxString userName = "".obs;
  final storeName = TextEditingController().obs;
  final city = TextEditingController().obs;
  final district = TextEditingController().obs;
  final area = TextEditingController().obs;
  final street = TextEditingController().obs;
  final approxSpace = TextEditingController().obs;
  final nationality = TextEditingController().obs;

  RxList<CityListModel> regionListData = <CityListModel>[].obs;
  RxList<CityListModel> cityListData = <CityListModel>[].obs;
  Rx<CityListModel> selectedRegion = CityListModel(id: 0,name: "").obs;
  Rx<CityListModel> selectedCity = CityListModel(id: 0,name: "").obs;
  final GlobalKey<FormFieldState> regionKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> cityKey = GlobalKey<FormFieldState>();

  RxString imageName = "".obs;
  RxString imagePath = "".obs;
  File? imageFile;
  RxBool isUploaded = false.obs;


  @override
  void onInit() {
    super.onInit();
    getRegionListData();
   // fetchLocation();
    getUserData();
  }
  Future<void> getUserData() async {
    userName.value = (await PrefUtils.instance.getString(AppConstants.userId))!;

  }
  Future<void> getImage() async {
    await ImageTakingService.imageSelect().then((value) {
      if (value == null) {
        return;
      }
      imageFile = value;
      imagePath.value = value.path;
      final String extension = path.extension(imageFile!.path);
      imageName.value = "${userName}_${DateTime.now().millisecondsSinceEpoch}$extension";
      print("Image name: ${imageName.value}");
      uploadFIleToGcs();
    });
  }



  uploadFIleToGcs() async {
    isLoading.value = true;
    isUploaded.value = false;
    try {
      final credentials = ServiceAccountCredentials.fromJson(
        await rootBundle.loadString('assets/google_cloud_creds/appimages-keycstoreapp-7c0f4-a6d4c3e5b590.json'),
      );

      final httpClient = await clientViaServiceAccount(credentials, [StorageApi.devstorageReadWriteScope]);
      final storage = StorageApi(httpClient);
     // imageName.value = '${DateTime.now().millisecondsSinceEpoch}';
      const bucketName = "cstore-bucket";
      final filePath = 'apsco_survey_photo/${imageName.value}';
      final fileContent = await imageFile!.readAsBytes();
      final bucketObject = Object(name: filePath);
      print("GCS path is");
      print(imageName.value);
      print(filePath);
      print(bucketName);
      // Upload the File
     await storage.objects.insert(
        bucketObject,
        bucketName,
        predefinedAcl: 'publicRead',
        uploadMedia: Media(
          Stream<List<int>>.fromIterable([fileContent]),
          fileContent.length,
        ),
      );
      Utils.showSnackBar("Image Upload successful", SnackType.success);
      isLoading.value = false;
      isUploaded.value = true;
    } catch (e) {
      // Handle any errors that occur during the upload
      isLoading.value = false;
      isUploaded.value = false;
      isLoading.value = false;
      Utils.showSnackBar("File upload error. upload file again ", SnackType.error);
    }
  }

  Future<void> getRegionListData() async {
    isRegionLoading.value=true;
    final httpManager = HTTPManager();
    await httpManager.fetchRegionList().then((result){
      if(result.status){
        regionListData.value=result.data;
        print("Check Region Data is");
        print(jsonEncode(result));
        isRegionLoading.value=false;
        if(regionListData.length == 1)  {
          selectedRegion.value = regionListData[0];
        } else {
         // getCityListData(selectedRegion.value.id);
          selectedRegion.value = CityListModel(id: 0,name: "");
        }
      }else{
        Utils.showSnackBar(result.msg, SnackType.error);
        isRegionLoading.value=false;
      }
    });
  }
  Future<void> getCityListData(int id) async {
    isCityLoading.value=true;
    final httpManager = HTTPManager();
    await httpManager.getCityListData(id).then((result){
      if(result.status){
        cityListData.value=result.data;
        print("Check city Data is");
        print(jsonEncode(result));
        isCityLoading.value=false;
        if(cityListData.length == 1)  {
          selectedCity.value = cityListData[0];
        } else {
          selectedCity.value = CityListModel(id: 0,name: "");
        }
      }else{
        Utils.showSnackBar(result.msg, SnackType.error);
        isCityLoading.value=false;
      }
    });
  }
  void saveApscoStore(BuildContext context) async {
    if (storeName.value.text.isEmpty ||
        selectedRegion.value.id==0||
        selectedCity.value.id==0||
        district.value.text.isEmpty ||
        area.value.text.isEmpty ||
        street.value.text.isEmpty ||
        approxSpace.value.text.isEmpty ||
        imageName.value.isEmpty||
        nationality.value.text.isEmpty) {
      Utils.showSnackBar("Please fill all fields", SnackType.error);
      return;
    }
    isLoading.value = true;
    print("Check controller location");
    print(currentLocation.value);
    final httpManager = HTTPManager();
    String? userId = await PrefUtils.instance
        .getString(AppConstants.userId);
    httpManager
        .saveStoreData(
      AddStoreDetailModel(
        storeId: "",
        userId: userId!,
        gCode: currentLocation.value,
        storeName: storeName.value.text,
        image: imageName.value.toString(),
        city: selectedCity.value.id,
        district: district.value.text,
        area: area.value.text,
        street: street.value.text,
        approxStoreSpace: approxSpace.value.text,
        nationality: nationality.value.text,
      ),
    )
        .then((result) async {
      if (result.status) {
        isLoading.value=false;
        final storeDetails = result.data.storeDetails;
        PrefUtils.instance.setString(AppConstants.storeId,storeDetails.storeId);
        PrefUtils.instance.setString(AppConstants.storeName,storeDetails.storeName);
        final questions = result.data.questions;
        print("Check Quesitions=========== ${jsonEncode(questions)}");
        DatabaseHelper.delete_table(DbConstant.sysTableEpscoQuestion);
        DatabaseHelper.delete_table(DbConstant.transTableEpscoAnswer);
        if (await DatabaseHelper.insertSysEpscoQuestionArray(questions)) {
          DatabaseHelper.insertTransEpscoSurvey(storeDetails.storeId);
         AlertNoteDialog.show(context);
        }
        Utils.showSnackBar(result.msg, SnackType.success);
        storeName.value.clear();
        city.value.clear();
        district.value.clear();
        approxSpace.value.clear();
        area.value.clear();
        nationality.value.clear();
        street.value.clear();
        imageName.value="";
        imageFile = null;
        imagePath.value = "";
      } else {
        isLoading.value=false;
        Utils.showSnackBar(result.msg, SnackType.error);
        print("error: ${result.msg}");
      }
    });
  }
}
