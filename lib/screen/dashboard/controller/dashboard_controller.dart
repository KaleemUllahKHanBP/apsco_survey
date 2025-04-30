import 'package:get/get.dart';
import 'package:survey/db_helper/db_helper.dart';
import 'package:survey/utils/app_constants.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';
import '../../../utils/services/location_services.dart';
import '../../survey/model/sys_epsco_survey_questions.dart';

class DashboardController extends GetxController{
     late PrefUtils prefUtils;
     RxString welcomeEnName="".obs;
     RxString userName="".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  Future<void> loadUserData() async {
    welcomeEnName.value = (await PrefUtils.instance.getString(AppConstants.enWellcomeMsg))!;
    userName.value = (await PrefUtils.instance.getString(AppConstants.userId))!;

    print("UserName and wellcome");
    print(welcomeEnName);
    print(userName);

  }
}