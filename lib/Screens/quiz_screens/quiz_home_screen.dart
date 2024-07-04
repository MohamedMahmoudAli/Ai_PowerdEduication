import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hieroglyphic_app/Screens/home_screen/home_screen.dart';
import 'package:hieroglyphic_app/compenets/cashe_helper.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:hieroglyphic_app/compenets/constants.dart';
import 'package:hieroglyphic_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../models/quiz_model/db_connect.dart';
import '../../models/quiz_model/question_model.dart';
import '../../widgets/next_button.dart';
import '../../widgets/option_card.dart';
import '../../widgets/question_widget.dart';
import '../../widgets/result_box.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
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
  @override
  void dispose() {
    _timer.cancel();
    //_controller.
    _controller.dispose();
    super.dispose();
  }

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

  Future uploadScore() async {
    await FirebaseFirestore.instance.collection('Quiz reslut').add({
      'name': "${CacheHelper.getData(key: 'name')}",
      'score': "$score/$questionLength",
      "cheating": cheating
    });
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

  void startOver() {
    setState(() {
      uploadScore();
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible:
              false, //disable the dismiss function on clicking outside of box
          builder: (ctx) {
            return ResultBox(
              onPressed: startOver,
              questionLength: questionLength,
              result: score,
              cheating: cheating,
            );
          });
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select answer"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 10),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  var db = DBconnect();
  late Future _questions;
  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    _resetApi();

    _controller = CameraController(
      camera![1],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      _startStreaming();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            questionLength = extractedData.length;
            return Scaffold(
              backgroundColor: AppColor.primaryColor,
              appBar: AppBar(
                title: const Text(
                  'Quiz Questions',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColor.primaryColor,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text('Score: $score',
                        style: const TextStyle(fontSize: 18, color: neutral1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text('Focus: $focus2',
                        style: const TextStyle(fontSize: 18, color: neutral1)),
                  )
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionWidget(
                            question: extractedData[index].title,
                            indexAction: index,
                            totalQuestions: extractedData.length),
                        const Divider(color: neutral1),
                        const SizedBox(height: 25),
                        for (int i = 0;
                            i < extractedData[index].options.length;
                            i++)
                          GestureDetector(
                            onTap: () => checkAnswerAndUpdate(
                                extractedData[index]
                                    .options
                                    .values
                                    .toList()[i]),
                            child: OptionCard(
                              option:
                                  extractedData[index].options.keys.toList()[i],
                              color: isPressed
                                  ? extractedData[index]
                                              .options
                                              .values
                                              .toList()[i] ==
                                          true
                                      ? correct
                                      : incorrect
                                  : neutral1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: NextButton(
                    textColor: Colors.black,
                    color: neutral1,
                    buttonText: 'Next Question',
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text('Please wait while Questions are loading..',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      fontSize: 14,
                    )),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
