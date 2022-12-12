import 'package:flutter/material.dart';
import 'package:yoga_frontend/constants/text_styles.dart';

import '../../../constants/colors.dart';

///The [OutlineMessage] is a custom widget that is used to display a message in a bordered container
///Used in the User Dashboard for showing slot and payment status
class OutlineMessage extends StatelessWidget {
  const OutlineMessage({required this.child, this.heading = "", super.key});
  final Widget child;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //The heading, shown above the bordered container
        Text(
          "$heading:",
          style: AppTextStyles.strongStyle.copyWith(fontSize: 20),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.buttonColor, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: child,
        ),
      ],
    );
  }
}
