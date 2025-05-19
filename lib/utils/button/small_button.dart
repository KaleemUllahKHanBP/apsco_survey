// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:survey/res/app_color.dart';
//
// class SmallButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final Color? backgroundColor;
//   final bool isFilled;
//   final IconData? icon;
//
//   const SmallButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor,
//     this.isFilled = true,
//     this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: isFilled
//           ? BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [appMainColorDark, appMainColorDark],
//         ),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: appMainColorDark.withOpacity(0.3),
//             blurRadius: 3,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       )
//           : null,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isFilled ? Colors.transparent : Colors.grey.shade300,
//           elevation: 2,
//           padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           shadowColor: Colors.transparent,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, color: Colors.white, size: 18),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               text,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: isFilled ? Colors.white : appMainColorDark,
//                 letterSpacing: 0.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool isFilled;
  final IconData? icon;
  final bool isLoading; // 👈 NEW

  const SmallButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isFilled = true,
    this.icon,
    this.isLoading = false, // 👈 default false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isFilled
          ? BoxDecoration(
        gradient: const LinearGradient(
          colors: [appMainColorDark, appMainColorDark],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: appMainColorDark.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      )
          : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // 👈 Disable when loading
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? Colors.transparent : Colors.grey.shade300,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.2,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isFilled ? Colors.white : appMainColorDark,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
