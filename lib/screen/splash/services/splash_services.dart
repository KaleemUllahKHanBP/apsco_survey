import 'dart:async';
import 'package:get/get.dart';
import 'package:survey/utils/app_constants.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';

import '../../../res/routes/routes.dart';

class SplashServices {
  static void checkLogin() async {
    bool isLoggedIn = await PrefUtils.instance.getBoolean(AppConstants.isLogin);
    Timer(const Duration(milliseconds: 3000), () {
      if (isLoggedIn) {
        Get.offNamed(Routes.mainDashboard);
      } else {
        Get.offNamed(Routes.loginScreen);
      }
    });
  }
}
