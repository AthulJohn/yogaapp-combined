import 'package:flutter/material.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';
import 'package:yoga_frontend/interface/components/academy_logo.dart';
import 'package:yoga_frontend/interface/screens/user_auth_screen/auth_screen.dart';
import '../../components/buttons.dart';
import '../know_more_page/know_more.dart';
import '../register_form/registration_form_screen.dart';

///The [HomePage] is the starting point of the app, it is the first screen that is shown to the user
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ArcBackground(
      heading: "Welcome to Nirvana",
      subheading: "Professional Yoga and Meditation Classes",
      child: HomeBody(),
    ));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //The Logo of the Institution, with the institution name
          const AcademyLogo(),
          //The buttons that are used to navigate to the other screens

          //New Registration Button
          AppElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            text: "New Registration",
          ),

          //Student Dashboard Button
          AppElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth');
            },
            text: "Student Dashboard",
          ),

          //Know More Button
          AppOutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/knowmore');
            },
            text: "Know more about the class",
          ),
        ]);
  }
}
