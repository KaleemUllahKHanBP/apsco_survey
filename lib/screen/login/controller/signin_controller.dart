import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:survey/utils/app_constants.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';
import '../../../../../utils/utils.dart';
import '../../../db_helper/db_constant.dart';
import '../../../db_helper/db_helper.dart';
import '../../../res/routes/routes.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../network_auth/authentication.dart';

class SignInController extends GetxController{
  RxBool nameFocus=false.obs;
  RxBool passwordFocus=false.obs;
  RxBool correctName=false.obs;
  RxBool showPassword=true.obs;
  RxBool loading=false.obs;
  final name=TextEditingController().obs;
  final password=TextEditingController().obs;
  RxBool isLoading = false.obs;
  late LoginResponseModel loginResponseData;
  late UserData userData;
  void setLoading(bool value){
    loading.value=value;
  }
  void onFocusName(){
    nameFocus.value=true;
    passwordFocus.value=false;
  }
  void onFocusPassword(){
    nameFocus.value=false;
    passwordFocus.value=true;
  }
  void onTapOutside(BuildContext context){
    nameFocus.value=false;
    passwordFocus.value=false;
    FocusScope.of(context).unfocus();
  }

  submitForm(BuildContext context) async {
    isLoading.value = true;
    if (name.value.text.isEmpty) {
      isLoading.value = false;
      Utils.showSnackBar("Enter username", SnackType.error);
      return;
    }
    if (password.value.text.isEmpty) {
      isLoading.value = false;
      Utils.showSnackBar("Enter password", SnackType.error);
      return;
    }
    isLoading.value = true;
    await Authentication()
        .loginUser(UserRequestModel(username: name.value.text, password: password.value.text))
        .then((value) async {
      print("Value is $value");
      loginResponseData = value;
      isLoading.value = true;
      if (value.status) {
        final userData = value.data.first;
        await PrefUtils.instance.setString(AppConstants.enWellcomeMsg,userData.enWelcomeMsg);
        await PrefUtils.instance.setString(AppConstants.token,userData.tokenId);
        await PrefUtils.instance.setString(AppConstants.userId,name.value.text);
        await PrefUtils.instance.setBoolean(AppConstants.isLogin,true);
        DatabaseHelper.delete_table(DbConstant.sysTableEpscoQuestion);
        DatabaseHelper.delete_table(DbConstant.transTableEpscoAnswer);
        Get.offNamed(Routes.mainDashboard);
        Utils.showSnackBar("Login successful!", SnackType.success);
        isLoading.value=false;
      } else {
        isLoading.value=false;
        Utils.showSnackBar("Error! ${value.msg} ", SnackType.error);
        print(value.msg);
      }
    }).catchError((onError) {
      isLoading.value = false;
      print("Check login error");
      print(onError.toString());
      Utils.showSnackBar(onError.toString(), SnackType.error);
    });
  }
}