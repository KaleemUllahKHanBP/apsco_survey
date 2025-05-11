import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title,required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.poppins(
            color: color, fontWeight: FontWeight.w500, fontSize: 15));
  }
}
