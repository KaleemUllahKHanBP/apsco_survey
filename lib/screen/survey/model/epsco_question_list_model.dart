import '../../../db_helper/db_constant.dart';
class EpscoSurveyListData {
  late int id;
  late String sysSurveyEnQuestion;
  late String sysSurveyArQuestion;
  late String sysSurveyAnswerType;
  late String transFirstAnswer;
  late String transSecondAnswer;
  late String transImageName;
  late String sysOnYesGetValue;
  late String sysOnYesGetImage;
  late String skuImage;
  late int gcsStatus;
  late int uploadStatus;

  EpscoSurveyListData({
    required this.id,
    required this.sysSurveyEnQuestion,
    required this.sysSurveyArQuestion,
    required this.sysSurveyAnswerType,
    required this.transFirstAnswer,
    required this.transSecondAnswer,
    required this.transImageName,
    required this.sysOnYesGetValue,
    required this.sysOnYesGetImage,
    required this.skuImage,
    required this.gcsStatus,
    required this.uploadStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_question': sysSurveyEnQuestion,
      'ar_question': sysSurveyArQuestion,
      'answer_type': sysSurveyAnswerType,
      'answer_first': transFirstAnswer,
      'answer_second': transSecondAnswer,
      'answer_images_name': transImageName,
      'on_yes_get_value': sysOnYesGetValue,
      'on_yes_get_image': sysOnYesGetImage,
      'sku_img': skuImage,
      DbConstant.gcsStatus: gcsStatus,
      DbConstant.uploadStatus: uploadStatus,
    };
  }
}