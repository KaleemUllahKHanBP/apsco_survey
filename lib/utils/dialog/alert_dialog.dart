import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/app_color.dart';
import '../../res/routes/routes.dart';

// BlinkingDot widget
class BlinkingDot extends StatefulWidget {
  const BlinkingDot({super.key});

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _startBlinking();
  }

  void _startBlinking() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 16.0,
        height: 16.0,
        decoration: const BoxDecoration(
          color: Colors.red,  // Color of the dot
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// AlertNoteDialog widget
class AlertNoteDialog {
  static void show(BuildContext context, {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon + Title
                    Column(
                      children: [
                        Text(
                          "Important Note",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: appMainColorDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your store is created, but it’s important to complete the full survey now."
                              "If you leave early, your changes won't be saved.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: appMainColorDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.surveyScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appMainColorDark,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Ok",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 10,
                left: 10,
                child: BlinkingDot(),
              ),
            ],
          ),
        );
      },
    );
  }
}
