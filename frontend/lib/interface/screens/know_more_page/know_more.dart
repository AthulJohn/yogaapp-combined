import 'package:flutter/material.dart';
import 'package:yoga_frontend/interface/components/arc_background.dart';

///The [KnowMorePage] is the screen that is used to show the details about the class
class KnowMorePage extends StatelessWidget {
  const KnowMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // resizeToAvoidBottomInset: false,
        body: ArcBackground(
      heading: "Welcome to Nirvana",
      subheading: "Professional Yoga and Meditation Classes",
      child: KnowMoreBody(),
    ));
  }
}

class KnowMoreBody extends StatelessWidget {
  const KnowMoreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              SizedBox(
                  height: 50,
                  child: Image.asset("assets/images/logo/bird.png")),
              const SizedBox(height: 10),
              Text(
                "Nirvana Academy of Yoga and Meditation",
                style: TextStyle(
                    color: Colors.pink[200],
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Text(
            "Niravana is one of the best spot to practise Yoga. We train Yoga on all weekends, with flexibe time.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Text(
            "Training is available for People between 18 to 65 Years Age.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Text(
            "You can choose any of the 4 time slots as you wish, and we will be happy to train you. Time slots selected can be changed anyday, but will be impacted only at the end of a month.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Text(
            "Fees for the training is Rs.500 per month, and you will need to pay the first month fees on the time of registration.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Text(
            "Contact 9999999999 for any queries.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ]);
  }
}
