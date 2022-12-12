import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/constants/colors.dart';
import 'package:yoga_frontend/constants/text_styles.dart';
import 'package:yoga_frontend/interface/components/academy_logo.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';
import 'package:yoga_frontend/interface/screens/dashboard/outlinemessage.dart';
import 'package:yoga_frontend/interface/screens/payment_screen/payment.dart';
import 'package:yoga_frontend/interface/screens/register_form/slot_radio_buttons.dart';
import '../../../constants/values.dart';
import '../../../models/person_model.dart';
import '../../../services/change_slot.dart';
import '../../components/buttons.dart';

///The [Dashboard] is the screen that is used to show the user's dashboard
///Shown after the user is authenticated
///User details are fetched from the provider
///Shows the user's name, registration ID, the slot they are registered for, the changed slot, and the fees status
///Shows the buttons to change the slot and to pay the fees
///Has a withdraw class button, which is not working yet
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // resizeToAvoidBottomInset: false,
        body: ArcBackground(
      heading: "Student Dashboard",
      child: DashboardBody(),
    ));
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody>
    with SingleTickerProviderStateMixin {
  bool logging = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Person>(builder: (context, person, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Shows a small logo without test
            const AcademyLogo(
              size: 40,
              hasText: false,
            ),
            Column(
              children: [
                //Shows the user's name in full CAPS and registration ID
                Text(person.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: 28,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold)),
                Text("Registration ID: ${person.id}",
                    style: TextStyle(color: AppColors.buttonColor)),
              ],
            ),
            //Shows a fees alert if the fees are due for more than 1 month or if the registration fees are not paid
            if (person.getFeesStatus == "M" || person.getFeesStatus == "RNP")
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                padding: const EdgeInsets.all(10),
                child: person.getFeesStatus == "M"
                    ? const Text(
                        "Fees due for multiple months. Pay your fees immediately",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subheading)
                    : const Text(
                        "Registration Fees not yet Paid. Pay your fees immediately",
                        style: AppTextStyles.subheading,
                        textAlign: TextAlign.center,
                      ),
              ),

            // Slot information
            Column(
              children: [
                OutlineMessage(
                  heading: "Slot",
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${slotsTime[person.slot]}",
                          style: AppTextStyles.strongStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //Slot Change Button, Changes the slot of the next month
                      AppElevatedButton(
                        onPressed: () {
                          openSlotChangeSheet(context, person);
                        },
                        text: "Change Slot",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Shows the changed slot if it is different from the current slot
                if (person.slot != person.changedslot)
                  Text(
                    "Next Month Slot: ${slotsTime[person.changedslot]}",
                    style: AppTextStyles.strongStyle.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),

            //Fees Status
            OutlineMessage(
              heading: "Fees Status",
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      person.getBeutifiedFeesStatus,
                      style: AppTextStyles.strongStyle.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Pay Fees button will be shown only if the fees are due
                  if (person.getFeesStatus != "P")
                    AppElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/payment',
                            arguments: true);
                      },
                      text: "Pay Fees",
                    ),
                ],
              ),
            ),

            //Withdraw from the class button, currently not implemented
            AppElevatedButton(
              onPressed: () {},
              text: "Withdraw from the class",
            ),
          ]);
    });
  }

  ///Opens the bottom sheet to change the slot
  void openSlotChangeSheet(BuildContext context, Person person) {
    showBottomSheet(
      enableDrag: true,
      elevation: 3,
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: SlotRadioButtons(
          onChanged: (val) {
            //The Change made is made in the provider for state updation
            Provider.of<Person>(context, listen: false).changeSlot(val);

            //The change is made in the database
            //Await is not called, and the app continues to function normally, while the change is made in the background
            changeSlot(Provider.of<Person>(context, listen: false).id, val);

            //Closes the bottom sheet, if a selection is made
            Navigator.pop(context);
          },
          slot: person.changedslot ?? 1,
        ),
      ),
    );
  }
}
