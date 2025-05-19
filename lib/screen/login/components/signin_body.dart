import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';
import '../../../../../utils/auth_button.dart';
import '../../../utils/password_textfield.dart';
import '../../../utils/username_textfield.dart';
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
                  width: 180,
                  height: 180,
                  child: Image.asset("assets/images/logo.png")),
            ),
            const SizedBox(height: 10,),
            Text(
              'LOG IN',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize:26,
                  color: appMainColorDark,),
            ),
            Text(
              'Login to your account',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:16,
                color: Colors.black,),
            ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const SizedBox(height:25),
              UserNameTextField(
                controller: controller.name.value,
                title: 'Username ',
                hint: 'Enter username',
                isIconShow: true,
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordTextField(
                controller: controller.password.value,
              ),
              const SizedBox(height:17)]
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
