import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey/utils/textfield_sufiix.dart';
import '../res/app_color.dart';

class LabeledTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool requiredField;

  const LabeledTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.requiredField = false, // Default to not required
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      cursorColor: appMainColorDark,
      maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: RichText(
          text: TextSpan(
            text: hint,
            style: const TextStyle(
              color: appMainColorDark,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            children: requiredField
                ? const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
                : [],
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: appMainColorDark,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent.shade100, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}









class CommentTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CommentTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      cursorColor: appMainColorLight,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIconColor: appMainColorDark,
        focusColor: appMainColorDark,
        fillColor: appMainColorDark,
        labelStyle: TextStyle(color: appMainColorDark.withOpacity(0.5), height: 1.5),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: appMainColorDark),
        ),
        border: const OutlineInputBorder(),
        label: RichText(
          text: TextSpan(
            text: hint,
            style: const TextStyle(color: appMainColorDark, fontSize: 16.0),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red,fontSize: 19,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

}