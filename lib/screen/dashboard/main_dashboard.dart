import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/db_helper/db_helper.dart';
import 'package:survey/res/app_color.dart';
import 'package:survey/utils/appbar/main_appbar.dart';
import '../../db_helper/db_constant.dart';
import '../../res/routes/routes.dart';
import 'controller/dashboard_controller.dart';
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: backgroundMain,
      appBar: const MainAppBar(
        title: "Dashboard",
        subTitle: "Welcome to APSCO Survey",
        isShowLogout: true,
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/bp_logo.png",
                fit: BoxFit.contain,
                width: 250,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              controller.welcomeEnName.value,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                wordSpacing: 5,
                color: Colors.black,
                height: 1.5,
              ),
            ),
            const Spacer(),
            _buildStartSurveyButton(),
            const Spacer(),
          ],
        ),
      ),
    ));
  }

  Widget _buildStartSurveyButton() {
    return GestureDetector(
      onTap: () {
        DatabaseHelper.delete_table(DbConstant.sysTableEpscoQuestion);
        DatabaseHelper.delete_table(DbConstant.transTableEpscoAnswer);
        Get.toNamed(Routes.addStoreScreen);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appMainColorDark.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 12),
            Text(
              "Start Survey",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: appMainColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
