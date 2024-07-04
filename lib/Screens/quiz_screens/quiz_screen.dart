import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/Screens/quiz_screens/quiz_home_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../compenets/constant/colors.dart';
import '../../compenets/constants.dart';
import '../../widgets/next_button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img.png',
                width: 470,
                height: 470,
              ),



              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizHomeScreen()));
                  },
                  child:   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: NextButton(
                      textColor: Colors.white,
                      buttonText: AppLocalizations.of(context)!.startquiz,
                      color: AppColor.primaryColor,
                    ),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
