import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/res/app_color.dart';
import 'package:survey/screen/survey/widget/survey_list_card.dart';
import 'package:survey/utils/appbar/main_appbar.dart';
import 'package:survey/utils/button/small_button.dart';
import '../../utils/auth_button.dart';
import '../../utils/dialog/finish_survey_dialog.dart';
import 'controller/survery_controller.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}
class _SurveyScreenState extends State<SurveyScreen> {
  final ApscoSurveyController controller = Get.put(ApscoSurveyController());
  void _finishSurvey() {
    controller.nextSurvey(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
              Scaffold(
        backgroundColor: backgroundMain,
        appBar: MainAppBar(
          title: "APSCO Survey",
          subTitle: controller.storeName.value,
          isShowLogout: true,
          showBackButton: false,
        ),
        body:controller.isDataLoading.value ?
        const Center(child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator()),) :
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: SurveyQuestionCard(
                    answerType: controller.surveyQuestions[controller.currentIndex.value].sysSurveyAnswerType,
                    onYesGetValue: controller
                        .surveyQuestions[controller.currentIndex.value].sysOnYesGetValue,
                    onYesGetImage: controller
                        .surveyQuestions[controller.currentIndex.value].sysOnYesGetImage,
                    valueControllerComment: controller.valueControllerComment.value,
                    question: controller
                        .surveyQuestions[controller.currentIndex.value].sysSurveyEnQuestion,
                    answers1: controller.surveyOptions,
                    selectedAnswerRadio:
                    controller.answersRadio[controller.currentIndex.value],
                    number: controller.currentIndex.value + 1,
                    onRadioSelect: (value) => controller.selectRadio(
                        controller.currentIndex.value, value),
                    isImageLoading: controller.isImageLoading.value,
                    getImage: () => controller.getImage(
                        controller.surveyQuestions[controller.currentIndex.value].id),
                    imagesList: controller.imagesList,
                    skuImage: controller.surveyQuestions[controller.currentIndex.value].skuImage,
                  ),
                ),
              ),

              controller.isButtonLoading.value
                  ? const Center(
                child: SizedBox(
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              )
                  : controller.currentIndex <
                  controller.surveyQuestions.length - 1
                  ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButton(
                      text: "Previous",
                      isFilled: false,
                      isLoading:controller.isButtonLoading.value,
                      onPressed: controller.currentIndex > 0
                          ? controller.previousSurvey
                          : null,
                      backgroundColor: Colors.grey,
                    ),
                    SmallButton(
                      text: "  Next   ",
                      isLoading:controller.isButtonLoading.value,
                      onPressed: (){
                        if (controller.currentIndex < controller.surveyQuestions.length - 1) {
                          controller.nextSurvey(context);
                        }
                      },
                    ),
                  ],
                ),
              )
                  :     Container(
                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: controller.isApscoSurveyFinishLoading.value
                        ? const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ):
                    AccountButton(text: "Finish",
                      loading: controller.isApscoSurveyFinishLoading.value,
                                    onTap: () {
                    FinsihSurveyDialog.show(context, _finishSurvey);
                                    },
                                  ),
                  ),

              // SmallButton(
              //   text: "  Finish  ",
              //   onPressed:(){
              //     FinsihSurveyDialog.show(context, _finishSurvey);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}








