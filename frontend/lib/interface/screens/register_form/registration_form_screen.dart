import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';
import 'package:yoga_frontend/interface/screens/register_form/slot_radio_buttons.dart';

import '../../../constants/text_styles.dart';
import '../../../models/person_model.dart';
import '../../../services/register.dart';
import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../payment_screen/payment.dart';
import 'text_fields_with_validation.dart';

///The [RegisterPage] is the screen that is used to register a new user
///Shown when a user clicks register button from the home screen
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ArcBackground(
      child: RegisterBody(),
    ));
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String name = '', phone = '';
  int age = 0, slot = 1;

  ///  Used to toggle the spinner when the user is registering
  bool logging = false;

  ///This function separates the async code from the UI code
  void registerUser({Function(int)? onSuccess, VoidCallback? onFailure}) async {
    // User Registration is done, on the Register page, even if the payment is not done, because Registration ID will be generated only after the registration in the backend
    int result = await registerPerson(
        Person(name: name, phone: phone, slot: slot, age: age));
    if (result == -1) {
      onFailure!.call();
    } else {
      onSuccess!.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      AppTextField(
        hintText: 'Name',
        labelText: 'Name',
        onChanged: (val) {
          name = val;
        },
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AgeField(
              onChanged: (val) {
                age = val;
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: PhoneField(
              onChanged: (val) {
                phone = val;
              },
            ),
          ),
        ],
      ),

      SlotRadioButtons(
        onChanged: (val) {
          slot = val;
        },
      ),
      //Empty Containers adds some gap between the fields and the button, since the MainAxisAlignment is spaceEvenly
      Container(),
      Container(),
      logging
          ?
          //if [logging] is true, the async function is running and the spinner is shown
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Signing Up...  ',
                  style: AppTextStyles.body,
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppElevatedButton(
                    onPressed: () async {
                      //age is set to -1, if the age is not valid
                      //If the age is not valid, the age field will be show an error, and the user won't be able to proceed
                      if (age == -1) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please Enter a Valid Age',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      //phone is set to "X", if it is not valid
                      //the phone field will be show an error, and the user won't be able to proceed
                      else if (phone == 'X') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please Enter a Valid Phone Number',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      } else {
                        //logging is set to true, to show the spinner
                        setState(() {
                          logging = true;
                        });
                        registerUser(onFailure: () {
                          if (!mounted) return;
                          setState(() {
                            logging = false;
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'An Error Occured',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }, onSuccess: (id) {
                          if (!mounted) return;
                          Provider.of<Person>(context, listen: false).setPerson(
                              Person(
                                  age: age,
                                  name: name,
                                  phone: phone,
                                  slot: slot,
                                  changedslot: slot,
                                  feePaidMonth: null,
                                  id: id,
                                  registerDate: DateTime.now()));
                          Navigator.pushReplacementNamed(context, '/payment');
                        });
                      }
                    },
                    text: 'PROCEED TO PAYMENT'),
              ],
            ),
    ]);
  }
}
