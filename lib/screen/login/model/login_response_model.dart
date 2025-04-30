import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool status;
  String msg;
  List<UserData> data;

  LoginResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        msg: json["msg"],
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserData {
  dynamic username;
  String enWelcomeMsg;
  String arWelcomeMsg;
  String tokenId;

  UserData({
    required this.username,
    required this.enWelcomeMsg,
    required this.arWelcomeMsg,
    required this.tokenId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    username: json["username"],
    enWelcomeMsg: json["en_welcome_msg"],
    arWelcomeMsg: json["ar_welcome_msg"],
    tokenId: json["token_id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "en_welcome_msg": enWelcomeMsg,
    "ar_welcome_msg": arWelcomeMsg,
    "token_id": tokenId,
  };
}
