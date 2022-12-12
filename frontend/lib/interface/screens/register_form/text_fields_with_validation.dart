import 'package:flutter/material.dart';

import '../../components/text_fields.dart';

///[AgeField] is a custom widget that is used to input and validate the age of the user
///Used in the registration form
class AgeField extends StatefulWidget {
  final Function(int)? onChanged;
  const AgeField({this.onChanged, Key? key}) : super(key: key);

  @override
  State<AgeField> createState() => _AgeFieldState();
}

class _AgeFieldState extends State<AgeField> {
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'XX',
      labelText: 'Age',
      keyboardType: TextInputType.number,
      errorText: age == -1
          ? "Kindly enter a valid number"
          : age > 65 || age < 18
              ? "Age Limit: 18-65 Years!"
              : null,
      onChanged: (val) {
        setState(() {
          age = int.tryParse(val) ?? -1;
        });
        if (age > 65 || age < 18) {
          widget.onChanged?.call(-1);
        } else {
          widget.onChanged?.call(age);
        }
      },
    );
  }
}

///The [PhoneField] is a custom widget that is used to input and validate the phone number
///Used in the registration form
class PhoneField extends StatefulWidget {
  final Function(String)? onChanged;
  const PhoneField({this.onChanged, Key? key}) : super(key: key);

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  int phone = 1000000000;
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: 'Phone Number',
      hintText: 'XXXXXXXXXX',
      keyboardType: TextInputType.number,
      errorText: phone > 9999999999 || phone < 1000000000
          ? "Kindly enter a valid phone number having 10 digits"
          : null,
      onChanged: (val) {
        setState(() {
          phone = int.tryParse(val) ?? -1;
        });
        if (phone > 9999999999 || phone < 1000000000) {
          widget.onChanged?.call("X");
        } else {
          widget.onChanged?.call(val);
        }
      },
    );
  }
}
