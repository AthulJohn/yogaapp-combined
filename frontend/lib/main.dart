import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/interface/screens/dashboard/dashboard.dart';
import 'package:yoga_frontend/interface/screens/home_screen/home_screen.dart';
import 'package:yoga_frontend/interface/screens/register_form/registration_form_screen.dart';
import 'package:yoga_frontend/interface/screens/user_auth_screen/auth_screen.dart';

import 'interface/screens/know_more_page/know_more.dart';
import 'interface/screens/payment_screen/payment.dart';
import 'models/person_model.dart';

void main() {
  runApp(const MyApp());
}

//State Management Technique used: Provider(Partially)
//Provider is used to store the data of the user, so that it can be accessed from anywhere in the app
//All other state management is done using setState, but making sure that the performance is not affected
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Person>(
        create: (context) => Person.empty(),
        child: MaterialApp(
          title: 'Yoga App',
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          routes: {
            '/': (context) => const HomePage(),
            '/home': (context) => const HomePage(),
            '/register': (context) => const RegisterPage(),
            '/dashboard': (context) => const Dashboard(),
            '/auth': (context) => const AuthorizePage(),
            '/payment': (context) => const PaymentsPage(),
            '/knowmore': (context) => const KnowMorePage(),
          },
        ));
  }
}
