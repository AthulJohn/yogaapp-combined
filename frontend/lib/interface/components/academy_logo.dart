import 'package:flutter/material.dart';

//Shows the logo of the academy and the academy name.
//Used in the home screen and the user dashboard
class AcademyLogo extends StatelessWidget {
  const AcademyLogo({this.size = 100, this.hasText = true, super.key});

  ///The size of the logo.
  ///Text Font Size is changed according to this value
  final double size;

  ///Whether to show the text or not
  final bool hasText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: size, child: Image.asset("assets/images/logo/bird.png")),
        const SizedBox(height: 10),
        if (hasText)
          Text(
            "Nirvana Academy of Yoga and Meditation",
            style: TextStyle(
                color: Colors.pink[200],
                //The font size will be having a base of 10 and will be increased by 0.12 times the size
                //So a size of 100 will have a font size of 10 + 0.12 * 100 = 22
                fontSize: 10 + 0.12 * size,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
