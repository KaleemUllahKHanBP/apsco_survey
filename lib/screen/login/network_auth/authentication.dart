import 'dart:convert';

import '../../../networks_api/app_url/application_url.dart';
import '../../../networks_api/response_handler.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
class Authentication {
  final ResponseHandler _handler = ResponseHandler();
  Future<LoginResponseModel> loginUser(
      UserRequestModel userResponseData) async {
    const url =ApplicationURLs.baseUrl+ApplicationURLs.loginUrl;
    print(url);
    print(jsonEncode(userResponseData));
    final response =
        await _handler.post(Uri.parse(url), userResponseData.toJson());
    LoginResponseModel loginResponseData = LoginResponseModel.fromJson(response);
    return loginResponseData;
  }
}


