import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';
import '../../../../../res/routes/routes.dart';
import '../../../../../utils/auth_button.dart';
import '../../../../../utils/text_field.dart';
import '../../../utils/title_text.dart';
import '../controller/signin_controller.dart';
class SignInBody extends StatelessWidget {
  SignInBody({super.key});
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Image.asset("assets/images/logo.png")),
            ),
            Text(
              'LOG IN',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize:26,
                  color: appMainColorDark,),
            ),
            Text(
              'Login to your account',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16,
                color: appMainColorLight,),
            ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const SizedBox(height:25),
              const Row(
                children: [
                  TitleText(title: "Username ", color: Colors.black,),
                  TitleText(title: "*", color: Colors.redAccent,)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(() => InputField(
                onTap: () => controller.onFocusName(),
                focus: controller.nameFocus.value,
                hint: "Enter username",
                controller: controller.name.value,
              )
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  TitleText(title: "Password ", color: Colors.black,),
                  TitleText(title: "*", color: Colors.redAccent,)
                ],
              ),
              const SizedBox(height:5),
              Obx(() =>InputField(
                onTap: () => controller.onFocusPassword(),
                focus: controller.passwordFocus.value,
                hint: "Enter password",
                controller: controller.password.value,
                hideText: controller.showPassword.value,
                onChange: () {},
                showPass: () => controller.showPassword.toggle(),
              ),
              ),
              const SizedBox(height:20)]
        ),
          AccountButton(
                text: "Login",
                loading: controller.isLoading.value,
                onTap: () {
                  controller.submitForm(context);
                },
              ),

          ],
        ),
      ),
    );
  }
}
