import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hieroglyphic_app/Screens/zoom/new_meeting.dart';
import 'package:tflite/tflite.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../compenets/constants.dart';
import '../main.dart';
import 'result_page.dart';

class VideoCall extends StatefulWidget {
  final String conferenceId;

  VideoCall({super.key, required this.conferenceId});
  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final int appID = int.parse(dotenv.get('ZEGO_APP_ID'));

  final String appSign = dotenv.get('ZEGO_APP_SIGIN');
  final controller = ZegoUIKitPrebuiltVideoConferenceController();

  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  String name = '';
 // cid = conferenceId;

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  //  loadFocusModel();


  }

  @override
  void dispose() {
    super.dispose();
    loadCamera().dispose();
    loadModel().dispose();
  //  loadFocusModel().dispose();
    runModel().dispose();
  }

  loadCamera() {
    cameraController = CameraController(camera![0], ResolutionPreset.ultraHigh);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          //  runFocusModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plan) {
            return plan.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: .1,
          asynch: true);
      predictions!.forEach((element) {
        output = element['label'];

        setState(() {
          output = element['label'];
          print('#####################');
          print(output);
          print('#####################');

          resultsCounter(output);
        });
      });
    }
  }




  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/models/model3.tflite',
        labels: 'assets/models/labels2.txt');
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appID,
        appSign: appSign.toString(),
        userID: userId,
        conferenceID: widget.conferenceId,
        controller: controller,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          background: Text(""),

          onLeave: () async {

            await FirebaseFirestore.instance.collection('results').doc('${widget.conferenceId}').get(

            ).then((value) {
              totalangry = angry+ value.get('anger');
              totaldisgust = disgust + value.get('disgust');
              totaleFear = fear + value.get('fear');
              totalhappy = happy + value.get('happy');
              totalneutral = neutral + value.get('neutral');
              totalsad = sad + value.get('sad');
              totalsurprise = surprise + value.get('surprise');
              totalsumOfResults= totalsad;




            });

            totalsumOfResults =  totalangry + totaldisgust + totaleFear + totalhappy + totalneutral +
                totalsad + totalsurprise;

            await FirebaseFirestore.instance.collection('results').doc('${widget.conferenceId}').set({
              'anger': totalangry,
              'disgust': totaldisgust,
              'fear': totaleFear,
              'happy': totalhappy,
              'neutral': totalneutral,
              'sad': totalsad,
              'surprise': totalsurprise,
              'sumOfResults': totalsumOfResults,

            });

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(

                  builder: (context) => ResultPage(),
                ));






          },
          leaveConfirmDialogInfo: ZegoLeaveConfirmDialogInfo(
            title: "Leave the conference",
            message: "Are you sure to leave the conference?",
            cancelButtonName: "Cancel",
            confirmButtonName: "ok",
          ),
          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user,
              Map extraInfo) {
            return user != null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://your_server/app/avatar/${user.id}.png',
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
        userName: 'user_ $userId',
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
