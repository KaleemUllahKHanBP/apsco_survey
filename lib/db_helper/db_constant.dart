class DbConstant {
  //*************** Table Names **********************
  static const String tblSysEpscoSurveyQues = "sys_epsco_survey";
  static const String sysTableEpscoQuestion = "sys_epsco_questions";
  static const String transTableEpscoAnswer = "trans_epsco_answers";


  // **************** Common Table Names ****************
  static const String id = "id";
  static const String clientId = "client_id";
  static const String gcsStatus = "gcs_status";
  static const String uploadStatus = "upload_status";
  static const String sysSurveyEnQuestion = "en_question";
  static const String sysSurveyArQuestion = "ar_question";
  static const String sysSurveyAnswerType = "answer_type";
  static const String sysSurveyOptQuestionId = "question_id";
  static const String enName = "en_name";
  static const String arName = "ar_name";
  static const String surveyImage = "image";

  // **************** Sys Column Names ****************

  static const String sysOnYesGetValue = "on_yes_get_value";
  static const String sysOnYesGetImage = "on_yes_get_image";
  static const String transImageName = "answer_images_name";
  static const String sysSurveyQuestionType = "type";
  static const String sysSurveySkuImage = "sku_img";


// **************** Trans Column Names ****************
  static const String transFirstAnswer = "answer_first";
  static const String transSecondAnswer = "answer_second";
  static const String transSurveyAnswer = "answer";
}
