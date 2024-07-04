import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:share_plus/share_plus.dart';

import '../../compenets/constants.dart';
import '../video_call.dart';

final String userId = Random().nextInt(900000 + 100000).toString();
final String randomConferenceId = Random()
    .nextInt(100000000 * 10 + Random().nextInt(10))
    .toString()
    .padLeft(10, '0');

void copyNumberToClipboard(String number) {
  Clipboard.setData(ClipboardData(text: number));
}

class NewMeeting extends StatefulWidget {
  static const String routeName = 'NewMeeting';

  const NewMeeting({Key? key}) : super(key: key);

  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  String name = '';

  jumpToMeetingPage(BuildContext context, {required String conferenceId}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoCall(conferenceId: conferenceId)));
    await FirebaseFirestore.instance.collection('results').doc('$conferenceId').set({
      'anger': 0,
      'disgust': 0,
      'fear': 0,
      'happy': 0,
      'neutral': 0,
      'sad': 0,
      'surprise': 0,
      'sumOfResults': 0,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_new_sharp, size: 35),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text(AppLocalizations.of(context)!.startMeeting),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                "assets/images/zoom2.png",
                fit: BoxFit.cover,
                height: 100,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.link),
                      title: SelectableText(
                        randomConferenceId,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          copyNumberToClipboard(randomConferenceId);
                          Fluttertoast.showToast(
                            msg: 'Copied',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.primaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                      ),
                    )),
              ),
              const Divider(thickness: 1, height: 40, indent: 20, endIndent: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share("Meeting Code : $randomConferenceId");
                },
                icon: const Icon(Icons.arrow_drop_down),
                label: Text(AppLocalizations.of(context)!.shareInvite),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 30),
                  primary: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  jumpToMeetingPage(context, conferenceId: randomConferenceId);
                },
                icon: const Icon(Icons.video_call),
                label: Text(AppLocalizations.of(context)!.startCall),
                style: OutlinedButton.styleFrom(
                  primary: AppColor.primaryColor,
                  side: const BorderSide(color: Colors.indigo),
                  fixedSize: Size(350, 30),
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

  void resultsCounter(String output) {
    switch (output) {
      case "0 angry":
        angry++;
        break;

      case "1 disgust":
        disgust++;

        break;

      case "2 fear":
        fear++;

        break;

      case "3 happy":
        happy++;

        break;

      case "4 neutral":
        neutral++;
        break;
      case "5 sad":
        sad++;

        break;
      case "6 surprise":
        surprise++;
        break;

      default:
        break;
    }

    sumOfResults = angry + disgust + fear + happy + neutral + sad + surprise;
  }
}
