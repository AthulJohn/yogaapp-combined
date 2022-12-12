import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

///The [AppTextField] is a custom widget that is used to display a customized text field
///Used as a base for all the text fields used in the app
class AppTextField extends StatelessWidget {
  final String? hintText, errorText, labelText;
  final Function(String) onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final TextEditingController? tec;
  const AppTextField(
      {required this.onChanged,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.hintText,
      this.errorText,
      this.labelText,
      this.suffix,
      this.tec,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tec,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        floatingLabelStyle: TextStyle(color: AppColors.tertiary),
        errorText: errorText,
        errorMaxLines: 3,
        hintText: hintText,
        hintStyle: AppTextStyles.hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.secondary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.tertiary,
            width: 1,
          ),
        ),
        fillColor: const Color.fromRGBO(255, 255, 255, 1),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
        isDense: true,
        suffixIconConstraints: const BoxConstraints(maxHeight: 33),
        suffixIcon: suffix,
      ),
      style: AppTextStyles.body.copyWith(fontSize: 18),
      cursorColor: AppColors.tertiary,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
