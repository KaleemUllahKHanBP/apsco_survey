// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:survey/res/app_color.dart';
// import 'package:survey/utils/dialog/logout_dialog.dart';
//
// class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String subTitle;
//   final bool isShowLogout;
//
//   const MainAppBar({super.key, required this.title, this.subTitle = "", required this.isShowLogout});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: appMainColorDark,
//       iconTheme: const IconThemeData(color: Colors.white),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Align title text to left
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//               fontSize: 15,
//             ),
//           ),
//           Text(
//             subTitle,
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w400,
//               color: Colors.white,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//        isShowLogout?IconButton(
//           icon: const Icon(Icons.logout_sharp, color: Colors.white),
//           tooltip: 'Logout',
//           onPressed: () {
//             LogoutDialog.show(context);
//           },
//         ):const SizedBox(),
//       ],
//     );
//   }
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }











import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_color.dart';
import '../dialog/logout_dialog.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final bool isShowLogout;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const MainAppBar({
    super.key,
    required this.title,
    this.subTitle = "",
    required this.isShowLogout,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appMainColorDark,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
         showBackButton?
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_left_outlined, color: Colors.white),
              onPressed: onBackPressed ?? () {
                Navigator.of(context).maybePop();
              },
            ):const SizedBox(width: 9,),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        isShowLogout
            ? IconButton(
          icon: const Icon(Icons.logout_sharp, color: Colors.white),
          tooltip: 'Logout',
          onPressed: () {
            LogoutDialog.show(context);
          },
        )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
