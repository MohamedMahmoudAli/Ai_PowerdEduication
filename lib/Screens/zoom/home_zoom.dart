import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/Screens/zoom/new_meeting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../compenets/constant/colors.dart';
import 'join_with_code.dart';

class HomeZoom extends StatelessWidget {
  const HomeZoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
            children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, NewMeeting.routeName);
              },
              icon: Icon(Icons.add),
              label: Text("${AppLocalizations.of(context)!.startMeeting}"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 30),
                primary: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 30,
            indent: 40,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, JoinWithCode.routeName);
              },
              icon: const Icon(Icons.margin),
              label:  Text("${AppLocalizations.of(context)!.joinWithCode}"),
              style: OutlinedButton.styleFrom(
                primary: AppColor.primaryColor,
                side: const BorderSide(color: Colors.indigo),
                fixedSize: const Size(350, 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
          SizedBox(height: 50),
          Image.asset('assets/images/zoom.png'),

        ]),
      ),
    );
  }
}
