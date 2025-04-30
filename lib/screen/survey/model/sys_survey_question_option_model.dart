import 'package:survey/db_helper/db_constant.dart';

class sysSurveyQuestionOptionModel {
  late int id;
  late int questionId;
  late String en_name;
  late String ar_name;
  late String answer_type;

  sysSurveyQuestionOptionModel({
    required this.id,
    required this.questionId,
    required this.en_name,
    required this.ar_name,
    required this.answer_type,
  });
  Map<String, Object?> toMap() {
    return {
      DbConstant.id: id,
      DbConstant.sysSurveyOptQuestionId:  questionId,
      DbConstant.enName: en_name,
      DbConstant.arName: ar_name,
      DbConstant.sysSurveyQuestionType: answer_type,
    };
  }

  sysSurveyQuestionOptionModel.fromJson(Map<String, dynamic> json) {
    id = json[DbConstant.id];
    questionId = json[DbConstant.sysSurveyOptQuestionId];
    en_name = json[DbConstant.enName] ?? "";
    ar_name = json[DbConstant.arName] ?? "";
    answer_type = json[DbConstant.sysSurveyQuestionType] ?? "";
  }
  Map<String, dynamic> toJson() => {
    DbConstant.id: id,
    DbConstant.sysSurveyOptQuestionId:  questionId,
    DbConstant.enName: en_name,
    DbConstant.arName: ar_name,
    DbConstant.sysSurveyQuestionType: answer_type,
  };

  @override
  String toString() {
    return 'sysSurveyQuestionOptionModel{id: $id, questionId: $questionId, en_name: $en_name, ar_name: $ar_name, type: $answer_type}';
  }
}


class TransSurveyModel {
  late int id;
  late int questionId;
  late String answerText;
  late String imageName;

  TransSurveyModel({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.imageName,
  });
  Map<String, Object?> toMap() {
    return {
      DbConstant.id: id,
      DbConstant.sysSurveyOptQuestionId:  questionId,
      DbConstant.transSurveyAnswer: answerText,
      DbConstant.surveyImage: imageName,
    };
  }

  TransSurveyModel.fromJson(Map<String, dynamic> json) {
    id = json[DbConstant.id];
    questionId = json[DbConstant.sysSurveyOptQuestionId];
    answerText = json[DbConstant.transSurveyAnswer] ?? "";
    imageName = json[DbConstant.surveyImage] ?? "";
  }
  Map<String, dynamic> toJson() => {
    DbConstant.id: id,
    DbConstant.sysSurveyOptQuestionId:  questionId,
    DbConstant.transSurveyAnswer: answerText,
    DbConstant.surveyImage: imageName,
  };

  @override
  String toString() {
    return 'sysSurveyQuestionOptionModel{id: $id, questionId: $questionId, answerText: $answerText, imageName: $imageName }';
  }
}
