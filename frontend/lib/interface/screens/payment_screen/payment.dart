import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';

import '../../../constants/values.dart';
import '../../../models/person_model.dart';
import 'payment_tile.dart';

///The [PaymentsPage] is the screen that is used to show the payment options
///Shown when a user clicks the payment button from the register screen or the user dashboard
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  ///dueNo is the number of months the user has not paid the fees for.
  ///Will be -1, if the user is redirected from the Register Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ArcBackground(
      child: PaymentsBody(
          fromDashboard:
              //true argument will be passed from dashboard while calling payments screen
              ((ModalRoute.of(context)!.settings.arguments) ?? false) as bool),
    ));
  }
}

class PaymentsBody extends StatelessWidget {
  const PaymentsBody({this.fromDashboard = false, Key? key}) : super(key: key);
  final bool fromDashboard;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      RichText(
        text: TextSpan(
          children: [
            const TextSpan(
                text: "Your Registration Id is ",
                style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "${Provider.of<Person>(context).id}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
          ],
        ),
      ),

      //Different Messages are shown, depending on whether the user is redirected from the Register Screen or the User Dashboard
      //If the user is redirected from the Register Screen, then the user has to pay the fees as a registration fees
      fromDashboard
          ? RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Colors.black),
                  children: [
                    const TextSpan(text: "Your total fees amount:"),
                    TextSpan(
                      //The total fees amount is calculated by multiplying the fees for each month by the number of months the user has not paid the fees for
                      text:
                          "Rs.${500 * Provider.of<Person>(context).getDueMonths}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextSpan(
                        text:
                            "(Fees due for last ${Provider.of<Person>(context).getDueMonths} months)."),
                  ]),
              textAlign: TextAlign.center,
            )
          : RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Colors.black),
                  children: [
                    const TextSpan(text: "You need to pay "),
                    const TextSpan(
                      text: "Rs.500",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextSpan(
                        text:
                            " as the fees for the month of ${months[DateTime.now().month - 1]} to complete your registration."),
                  ]),
              textAlign: TextAlign.center,
            ),
      const Text("Select your Payment Option"),
      //Different Payment Options are shown, Butall the methods does the same thing, i.e. calls the completePayment Function in the backend
      PaymentTile(
        text: "via UPI",
        id: Provider.of<Person>(context).id,
        image:
            "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2017/11/upi-1509594508.jpg",
        fromdashboard: fromDashboard,
        amount: 500.0 * Provider.of<Person>(context).getDueMonths,
      ),
      PaymentTile(
        text: "via Netbanking",
        id: Provider.of<Person>(context).id,
        icon: const Icon(Icons.mouse_rounded),
        fromdashboard: fromDashboard,
        amount: 500.0 * Provider.of<Person>(context).getDueMonths,
      ),
      PaymentTile(
        text: "using Debit/Credit Card",
        id: Provider.of<Person>(context).id,
        icon: const Icon(Icons.credit_card),
        fromdashboard: fromDashboard,
        amount: 500.0 * Provider.of<Person>(context).getDueMonths,
      ),
      Container(),
      Container(),
    ]);
  }
}
