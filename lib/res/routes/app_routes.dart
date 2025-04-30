import 'package:get/get.dart';
import 'package:survey/res/routes/routes.dart';
import '../../screen/dashboard/main_dashboard.dart';
import '../../screen/login/sign_in.dart';
import '../../screen/splash/splash_screen.dart';
import '../../screen/store/add_store.dart';
import '../../screen/survey/survey_screen.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
      GetPage(name: Routes.loginScreen, page: () => const SignIn()),
      GetPage(name: Routes.mainDashboard, page: () => const MainDashboard()),
      GetPage(name: Routes.surveyScreen, page: () => const SurveyScreen()),
      GetPage(name: Routes.addStoreScreen, page: () => const AddStoreScreen()),
    ];
  }
}
