import 'package:flutter/material.dart';
import 'package:survey/res/app_color.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Password can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,

        label: RichText(
          text: const TextSpan(
            text: 'Password ',
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),

        prefixIcon: const Padding(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.lock,
            color: appMainColorDark,
          ),
        ),

        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: appMainColorDark),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: appMainColorDark, width: 1.0),
        ),

        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide(color: appMainColorDark),
        ),
      ),
    );
  }
}
