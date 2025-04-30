import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/screen/splash/services/splash_services.dart';
import '../../res/app_color.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    SplashServices.checkLogin();
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundMain,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Circle with soft shadow
              SizedBox(
                child: SvgPicture.asset(
                  "assets/images/app_icon.svg",
                  fit: BoxFit.contain,
                  width: 200,height: 200,
                ),
              ),

              const SizedBox(height: 30),

              // App Name
              Text(
                "Apsco Survey",
                style: GoogleFonts.vollkorn(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: appMainColorDark,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
