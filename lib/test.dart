import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart'as http;
import 'package:image/image.dart' as img;


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hieroglyphic_app/Screens/result_page.dart';
import 'package:hieroglyphic_app/Screens/zoom/new_meeting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../compenets/constants.dart';
import '../main.dart';

class Test extends StatefulWidget {
  final String conferenceId;


  Test({super.key, required this.conferenceId});
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final int appID = int.parse(dotenv.get('ZEGO_APP_ID'));

  final String appSign = dotenv.get('ZEGO_APP_SIGIN');
  final controller = ZegoUIKitPrebuiltVideoConferenceController();

  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  String name = '';
  
  get http => null;
 // cid = conferenceId;

  @override
  void initState() {
    _resetApi();

    _controller = CameraController(
      camera![1],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      _startStreaming();
    });
    super.initState();
    
  //  loadFocusModel();


  }

  @override
  void dispose() {
    super.dispose();
    
  }

 
 int index = 0;
  int score = 0;
  bool isAlreadySelected = false;
  bool isPressed = false;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Timer _timer;
  String? _response;
  late double percentageFocus = 75.0;
  int focus2 = 75;
  String cheating = '';
  int questionLength = 0;

  Future<void> _resetApi() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://f424-41-234-107-238.ngrok-free.app/reset'), // Replace with your Flask API URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{'reset': 0}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Reset Response: $jsonResponse');
      } else {
        print('Failed to reset: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error during reset: $e');
    }
  }

 

  Uint8List resizeImage(Uint8List imageBytes,
      {required int width, required int height}) {
    img.Image? image = img.decodeImage(imageBytes);
    if (image != null) {
      img.Image resizedImage =
          img.copyResize(image, width: width, height: height);
      Uint8List resizedBytes = Uint8List.fromList(img.encodeJpg(resizedImage));
      return resizedBytes;
    } else {
      throw Exception('Failed to decode image.');
    }
  }

  void _startStreaming() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await _captureAndUploadFrame();
    });
  }

  Future<void> _captureAndUploadFrame() async {
    try {
      checkCheating();
      await _initializeControllerFuture;

      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String filePath = '$tempPath/frame.jpg';

      XFile picture = await _controller.takePicture();
      await picture.saveTo(filePath);

      File file = File(filePath);

      if (await file.exists()) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://f424-41-234-107-238.ngrok-free.app/upload'), // Replace with your Flask API URL
        );
        request.files.add(await http.MultipartFile.fromPath('images[]', file.path));

        var response = await request.send();

        print("Response status: ${response.statusCode}");
        print("Response: $response");

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final jsonResponse = json.decode(responseBody);
          print(jsonResponse);
          setState(() {
            _response = jsonResponse.toString();
            percentageFocus = jsonResponse['percentage_focus'];
             focus2 = percentageFocus.truncate();

            print("Percentage Focus: $percentageFocus");
            print("Focus: $focus2");

            if (percentageFocus <= 50.0) {
              cheating = 'Cheat';
            } else {
              cheating = 'Not cheating';
            }
          });
        } else {
          setState(() {
            _response = 'Error: ${response.reasonPhrase}';
          });
        }

        await file.delete(); // Delete the temporary file after sending
      } else {
        print('File does not exist');
      }
    } catch (e) {
      print(e);
    }
  }

  checkCheating() {
    if (percentageFocus <= 50.0) {
      cheating = 'Cheating';
    } else {
      cheating = ' Not cheating';
    }
  }

  




  



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appID,
        appSign: appSign.toString(),
        userID: userId,
        conferenceID: "25454454",
        controller: controller,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          background: Text(""),

          onLeave: () async {

            
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

  
}
