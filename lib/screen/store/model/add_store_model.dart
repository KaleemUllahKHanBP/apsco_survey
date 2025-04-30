import '../../survey/model/sys_epsco_survey_questions.dart';

class AddStoreResponseModel {
  bool status;
  String msg;
  StoreDataModel data;

  AddStoreResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory AddStoreResponseModel.fromJson(Map<String, dynamic> json) {
    return AddStoreResponseModel(
      status: json['status'],
      msg: json['msg'],
      data: StoreDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'data': data.toJson(),
    };
  }
}

class StoreDataModel {
  AddStoreDetailModel storeDetails;
  List<SysEpscoSurveyQuestionModel> questions;

  StoreDataModel({
    required this.storeDetails,
    required this.questions,
  });

  factory StoreDataModel.fromJson(Map<String, dynamic> json) {
    return StoreDataModel(
      storeDetails: AddStoreDetailModel.fromJson(json['store details']),
      questions: (json['questions'] as List<dynamic>)
          .map((item) => SysEpscoSurveyQuestionModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store details': storeDetails.toJson(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class AddStoreDetailModel {
  String userId;
  String storeId;
  String gCode;
  String storeName;
  String image;
  int city;
  String district;
  String area;
  String street;
  String approxStoreSpace;
  String nationality;

  AddStoreDetailModel({
    required this.userId,
    required this.storeId,
    required this.gCode,
    required this.storeName,
    required this.image,
    required this.city,
    required this.district,
    required this.area,
    required this.street,
    required  this.approxStoreSpace,
    required this.nationality,
  });

  factory AddStoreDetailModel.fromJson(Map<String, dynamic> json) {
    return AddStoreDetailModel(
      userId: json['user_id'].toString(),
      storeId: json['store_id'].toString(),
      gCode: json['g_code'].toString(),
      storeName: json['store_name'],
      image: json['image'].toString(),
      city: json['city'],
      district: json['district'],
      area: json['area'],
      street: json['street'].toString(),
      approxStoreSpace: json['approx_store_space'].toString(),
      nationality: json['nationality'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'store_id': storeId,
      'g_code': gCode,
      'store_name': storeName,
      'image': image,
      'city': city,
      'district': district,
      'area': area,
      'street': street,
      'approx_store_space': approxStoreSpace,
      'nationality': nationality,
    };
  }
}