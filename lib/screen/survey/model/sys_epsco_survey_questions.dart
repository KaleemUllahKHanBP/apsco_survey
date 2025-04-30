
import '../../../db_helper/db_constant.dart';

class SysEpscoSurveyQuestionModel {
  late int id;
  late String sysSurveyEnQuestion;
  late String sysSurveyArQuestion;
  late String sysSurveyAnswerType;
  late String sysOnYesGetValue;
  late String sysOnYesGetImage;


  SysEpscoSurveyQuestionModel({
    required this.id,
    required this.sysSurveyEnQuestion,
    required this.sysSurveyArQuestion,
    required this.sysSurveyAnswerType,
    required this.sysOnYesGetValue,
    required this.sysOnYesGetImage,
  });
  Map<String, Object?> toMap() {
    return {
      DbConstant.id: id,
      DbConstant.sysSurveyEnQuestion:  sysSurveyEnQuestion,
      DbConstant.sysSurveyArQuestion: sysSurveyArQuestion,
      DbConstant.sysSurveyAnswerType: sysSurveyAnswerType,
      DbConstant.sysOnYesGetValue: sysOnYesGetValue,
      DbConstant.sysOnYesGetImage: sysOnYesGetImage,
    };
  }


  SysEpscoSurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    id = json[DbConstant.id];
    sysSurveyEnQuestion = json[DbConstant.sysSurveyEnQuestion] ?? "";
    sysSurveyArQuestion = json[DbConstant.sysSurveyArQuestion] ?? "" ;
    sysSurveyAnswerType = json[DbConstant.sysSurveyAnswerType] ?? "" ;
    sysOnYesGetValue = json[DbConstant.sysOnYesGetValue] ?? "";
    sysOnYesGetImage = json[DbConstant.sysOnYesGetImage] ?? "";
  }
  Map<String, dynamic> toJson() => {
    DbConstant.id: id,
    DbConstant.sysSurveyEnQuestion : sysSurveyEnQuestion,
    DbConstant.sysSurveyArQuestion: sysSurveyArQuestion,
    DbConstant.sysSurveyAnswerType: sysSurveyAnswerType,
    DbConstant.sysOnYesGetValue: sysOnYesGetValue,
    DbConstant.sysOnYesGetImage: sysOnYesGetImage,
  };

  @override
  String toString() {
    return 'SysEpscoSurveyQuestionModel{id: $id, sysSurveyEnQuestion: $sysSurveyEnQuestion, sysSurveyArQuestion: $sysSurveyArQuestion, sysSurveyAnswerType: $sysSurveyAnswerType, sysOnYesGetValue: $sysOnYesGetValue, sysOnYesGetImage: $sysOnYesGetImage}';
  }
}