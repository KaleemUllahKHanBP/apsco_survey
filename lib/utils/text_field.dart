import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey/utils/textfield_sufiix.dart';
import '../res/app_color.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.onTap,
    this.focus = false,
    required this.hint,
    required this.controller,
    this.correct,
    this.onChange,
    this.hideText,
    this.showPass,
    this.showPasswordToggle = false,
    this.validator
  });

  final bool focus;
  final String hint;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final VoidCallback? onChange;
  final VoidCallback? showPass;
  final bool? hideText;
  final bool? correct;
  final bool showPasswordToggle;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 66,
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: focus
            ? const LinearGradient(colors: [
          appMainColorLight,
          appMainColorDark,
        ])
            : null,
      ),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        onChanged: (value) => onChange?.call(),
        obscureText: hideText ?? false,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          suffixIcon: _buildSuffixIcon(),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (hideText == null) {
      return correct == true
          ? const TextFieldSufix(icon: Icons.done)
          : null;
    }

    if (showPasswordToggle && controller.text.isNotEmpty) {
      return GestureDetector(
        onTap: showPass,
        child: hideText!
            ? const TextFieldSufix(icon: FontAwesomeIcons.eye, size: 13)
            : const TextFieldSufix(icon: FontAwesomeIcons.eyeLowVision, size: 13),
      );
    }
    return null;
  }
}








class LabeledTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const LabeledTextFormField({
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
        filled: true,
        fillColor: Colors.white,
        labelText: hint,
        labelStyle: const TextStyle(
          color: appMainColorDark,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: const TextStyle(
          color: appMainColorLight,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent.shade100, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          borderRadius: BorderRadius.circular(8),
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
            labelStyle:
            const TextStyle(color: appMainColorDark, height: 50.0),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: appMainColorDark)),
            border: const OutlineInputBorder(),
            labelText: hint),
    );
  }
}