
class ApscoSurveyRequest {
  final String storeId;
  final List<ApscoSurveyRequestData> surveyList;

  ApscoSurveyRequest({
    required this.storeId,
    required this.surveyList,
  });

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'answers': surveyList.map((image) => image.toJson()).toList(),
    };
  }
}

class ApscoSurveyRequestData {
  final int questionId;
  final String answerRadio;
  final String answerText;
  final String imageNames;

  ApscoSurveyRequestData({
    required this.questionId,
    required this.answerRadio,
    required this.answerText,
    required this.imageNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer_radio': answerRadio,
      'answer_text': answerText,
      'image': imageNames,
    };
  }
}