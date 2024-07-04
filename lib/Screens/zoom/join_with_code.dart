import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../video_call.dart';

class JoinWithCode extends StatelessWidget {
  static const String routeName = 'joinWithCode';
  final conferenceController = TextEditingController();

  jumpToMeetingPage(BuildContext context, {required String conferenceId}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VideoCall(
        conferenceId:conferenceId
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios_new_sharp, size: 35),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(AppLocalizations.of(context)!.join),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 50),
              Image.network(
                "https://user-images.githubusercontent.com/67534990/127776450-6c7a9470-d4e2-4780-ab10-143f5f86a26e.png",
                fit: BoxFit.cover,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.meetingCode,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                color: AppColor.primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: conferenceController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.exampleCode),
                  ),
                ),
              ),
              ElevatedButton(
            onPressed: () => jumpToMeetingPage(context,
          conferenceId: conferenceController.text),

                child: Text(AppLocalizations.of(context)!.join),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(50, 30),
                  primary: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}