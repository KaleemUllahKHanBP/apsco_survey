import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onTap;
  final String? tag;
  const AccountButton({super.key, required this.text, required this.loading, required this.onTap,this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag?? "TAG",
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 58,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  colors: [appMainColorDark, appMainColorLight])
          ),
          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Material(
            color: Colors.transparent,
                child: Text(
                    text,
                    style: GoogleFonts.poppins( color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)
                  ),
              ),
        ),
      ),
    );
  }
}
