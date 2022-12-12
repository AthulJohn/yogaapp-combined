import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

///The [ArcBackground] is a custom widget that is used to display a curved background.
///Also Provides a heading and subheading.
///Used in all the pages of the app, to show the curved background
class ArcBackground extends StatelessWidget {
  const ArcBackground(
      {this.heading = "Let's get Started!",
      this.subheading = '',
      required this.child,
      super.key});

  final String heading;

  ///Subheading can be empty, and if so, no space will be alloted for the subheading
  final String subheading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.tertiary,
        child: SafeArea(
          child: Container(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        //The curved background, shown behind the heading and subheading
                        //An SVG image is used as the background
                        SvgPicture.asset(
                          'assets/images/design/onboarding1_head copy.svg',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(),
                              //Heading and the Subheading
                              Column(children: [
                                Text(
                                  heading,
                                  style: AppTextStyles.heading,
                                ),
                                if (subheading.isNotEmpty)
                                  Text(
                                    subheading,
                                    style: AppTextStyles.subheading,
                                  ),
                              ])
                            ],
                          ),
                        ),
                      ],
                    )),

                //A Stack is used to display the 2 arcs design shown in the sides of the every page
                Expanded(
                  flex: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //A PNG image is used for the arcs design
                      Positioned(
                        top: 30,
                        left: 0,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child:
                            Image.asset('assets/images/design/LeftCircles.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                            'assets/images/design/RightCircles.png'),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
