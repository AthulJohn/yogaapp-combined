import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_frontend/constants/colors.dart';
import 'package:yoga_frontend/interface/screens/dashboard/dashboard.dart';
import 'package:yoga_frontend/models/person_model.dart';

import '../../../constants/text_styles.dart';
import '../../../services/complete_payment.dart';

//Each payment tile is a list tile that is used to display the payment options
class PaymentTile extends StatefulWidget {
  const PaymentTile(
      {required this.id,
      required this.text,
      this.image,
      this.amount = 500,
      this.fromdashboard = false,
      this.icon,
      super.key});
  final int id;
  final String text;

  ///Image is passed only in the case of UPI, and in that case, icon will be null
  final String? image;

  ///Image is passed only in the case of Netbanking/Card Payment, and in that case, image will be null
  final Icon? icon;
  final bool fromdashboard;
  final double amount;
  @override
  State<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
  ///  Used to toggle the spinner when the user is registering
  bool logging = false;

  ///This function separates the async code from the UI code
  void payFees({VoidCallback? onSuccess, VoidCallback? onFailure}) async {
    bool result = await completePayment(widget.id, widget.text, widget.amount);
    // A delay is added, to emulate real world payment processing
    await Future.delayed(const Duration(seconds: 3));
    if (!result) {
      onFailure!.call();
    } else {
      onSuccess!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return logging
        //If the user is paying, show a spinner
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Payment processing...  ',
                style: AppTextStyles.body,
              ),
              CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.buttonColor, width: 2),
            ),
            child: ListTile(
                title: Text("Pay ${widget.text}"),
                //If the image is null, show the icon, else show the image
                leading: widget.image == null
                    ? widget.icon
                    : SizedBox(
                        width: 50,
                        child: Image.network(
                          widget.image!,
                          errorBuilder: (context, error, stackTrace) =>
                              const Text("UPI"),
                        )),
                onTap: () async {
                  setState(() {
                    logging = true;
                  });
                  payFees(
                    onFailure: () {
                      if (!mounted) return;
                      setState(() {
                        logging = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'An Error Occured',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    },
                    onSuccess: () {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Payment Successful',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ));
                      Provider.of<Person>(context, listen: false).payFees();
                      if (widget.fromdashboard) {
                        //If the user is paying from the dashboard, Go back to the dashboard
                        Navigator.pop(context);
                      } else {
                        //If the user is paying from the payment screen, Go to the dashboard
                        //Else, The user will need to authenticate again
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      }
                    },
                  );
                }),
          );
  }
}
