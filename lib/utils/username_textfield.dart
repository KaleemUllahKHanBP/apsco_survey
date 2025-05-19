import 'package:flutter/material.dart';
import 'package:survey/res/app_color.dart';
class UserNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final bool isIconShow;
  const UserNameTextField({super.key, required this.controller, required this.title, required this.hint, required this.isIconShow});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      enableInteractiveSelection: false,
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "field can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,

        label: RichText(
          text:  TextSpan(
            text: title,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),

        prefixIcon:isIconShow ? const Padding(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.person_outline,
            color: appMainColorDark,
          ),
        ):null,

        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: appMainColorDark, width: 1.0),
        ),

        border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
      ),
    );
  }
}
