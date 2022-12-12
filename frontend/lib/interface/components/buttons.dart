import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

///The [AppElevatedButton] is a custom widget that is used to display a customized elevated button
///Most of the buttons in the app are based on this widget
class AppElevatedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? fontSize, padding;
  const AppElevatedButton(
      {required this.onPressed,
      required this.text,
      this.fontSize,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
        padding: padding != null
            ? MaterialStateProperty.all(EdgeInsets.symmetric(
                horizontal: padding!, vertical: (padding!) / 2))
            : null,
      ),
      child: Text(
        text,
        style: AppTextStyles.bold.copyWith(fontSize: fontSize),
      ),
    );
  }
}

///The [AppOutlinedButton] is a custom widget that is used to display a customized outlined button
///Used in the Homepage, for the show more button
class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? fontSize, padding;
  const AppOutlinedButton(
      {required this.onPressed,
      required this.text,
      this.fontSize,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: padding != null
              ? MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: padding!, vertical: (padding!) / 2))
              : null,
          side: MaterialStateProperty.all(
              BorderSide(color: AppColors.buttonColor, width: 2))),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: AppColors.buttonColor),
      ),
    );
  }
}
