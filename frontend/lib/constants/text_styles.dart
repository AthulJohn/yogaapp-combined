import 'package:flutter/material.dart';
import './colors.dart';

///The [AppTextStyles] is a class that contains various text styles used in the app
abstract class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle subheading = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle hintStyle = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    // fontWeight: FontWeight.bold,
  );

  static const TextStyle radioText = TextStyle(fontSize: 18);
  static TextStyle radioTextSelected = TextStyle(
      fontSize: 18, color: AppColors.buttonColor, fontWeight: FontWeight.bold);

  static const TextStyle mini = TextStyle(
    fontSize: 13,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontSize: 15,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle bold =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w900);

  static const TextStyle medFullBold =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  static const TextStyle bigBold =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle textButtonStyle = TextStyle(
      fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.buttonColor);

  static TextStyle strongStyle = TextStyle(
      fontSize: 23, fontWeight: FontWeight.bold, color: AppColors.buttonColor);
}
