import 'package:flutter/material.dart';
import 'package:survey/res/app_color.dart';
import '../../utils/appbar/main_appbar.dart';
import 'components/signin_body.dart';
class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundMain ,
      appBar: const MainAppBar(title: "Login",isShowLogout: false,),
      body: SafeArea(
        child: SignInBody(),
      ),
    );
  }
}
