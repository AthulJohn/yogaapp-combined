import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';
import 'package:yoga_frontend/interface/screens/dashboard/dashboard.dart';
import 'package:yoga_frontend/services/authorize.dart';
import '../../../constants/text_styles.dart';
import '../../../models/person_model.dart';
import '../../components/buttons.dart';
import '../../components/text_fields.dart';

//The Authentication Screen shows when the user clicks on student dashboard option from the home screen
//It is used as an alternative to login signin where, the Registeration ID and phone number is used to identify a user
//The method is not secure, but does the purpose for now

class AuthorizePage extends StatelessWidget {
  const AuthorizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ArcBackground(
      heading: "Student Authorize",
      subheading: "Authorization",
      child: AuthorizeBody(),
    ));
  }
}

class AuthorizeBody extends StatefulWidget {
  const AuthorizeBody({Key? key}) : super(key: key);

  @override
  State<AuthorizeBody> createState() => _AuthorizeBodyState();
}

class _AuthorizeBodyState extends State<AuthorizeBody> {
  String phone = "";

  String id = "";
  bool logging = false;

  void authorizeUser(
      {Function(Person)? onSuccess, VoidCallback? onFailure}) async {
    Person? pers = await authorize(id, phone);
    if (pers == null) {
      onFailure!.call();
    } else {
      onSuccess!.call(pers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        'Enter your Register ID and Phone Number to authorize yourself.',
        style: AppTextStyles.radioTextSelected,
        textAlign: TextAlign.center,
      ),
      AppTextField(
        hintText: 'Register ID',
        labelText: 'Enter your Register ID',
        onChanged: (val) {
          id = val;
        },
      ),
      AppTextField(
        hintText: 'XXXXXXXXXX',
        labelText: 'Enter your Registered Phone Number',
        onChanged: (val) {
          phone = val;
        },
      ),
      Container(),
      Container(),
      logging
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Authorizing...  ',
                  style: AppTextStyles.body,
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                )
              ],
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              AppElevatedButton(
                  onPressed: () async {
                    setState(() {
                      logging = true;
                    });
                    authorizeUser(onFailure: () {
                      if (!mounted) return;
                      setState(() {
                        logging = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Authorization Failed',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }, onSuccess: (Person pers) {
                      if (!mounted) return;
                      Provider.of<Person>(context, listen: false)
                          .setPerson(pers);
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    });
                  },
                  text: 'AUTHORIZE'),
            ]),
    ]);
  }
}
