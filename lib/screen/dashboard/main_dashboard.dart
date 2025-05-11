import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Obx(()=>Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.welcomeEnName.value,
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: appMainColorDark,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      DatabaseHelper.delete_table(DbConstant.sysTableEpscoQuestion);
                      DatabaseHelper.delete_table(DbConstant.transTableEpscoAnswer);
                      Get.toNamed(Routes.addStoreScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.book,
                            size: 46,
                            color: appMainColorDark,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Start Survey",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: appMainColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Add more buttons here if needed
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
