import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/Screens/result_page.dart';
import 'package:hieroglyphic_app/main.dart';
import 'package:tflite/tflite.dart';
import '../compenets/constants.dart';

class TestReal extends StatefulWidget {
  static const String routeName = 'realtime';
  @override
  State<TestReal> createState() => _TestRealState();
}

class _TestRealState extends State<TestReal> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    loadCamera().dispose();
    loadModel().dispose();
    //  runModel().dispose();
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
            runModel(); // runModel();
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
          print(output);
          resultsCounter(output);
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/models/best2.tflite',
        labels: 'assets/models/labels.txt');
        // model: 'assets/models/best-fp16.tflite',
        // labels: 'assets/models/best-fp.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test real'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!)),
            ),
          ),
          Text(
            output,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(),
                    ));
              },
              child: Text('Exit'))
        ]),
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

    print('----------------------------------------------------');
    print('----------------------------------------------------');
    print("angry $angry");
    print("disgust $disgust");
    print("fear $fear");
    print("happy $happy");
    print("neutral $neutral");
    print("sad $sad");
    print("surprise $surprise");
    print("sumOfResults $sumOfResults");
    print('----------------------------------------------------');
    print('----------------------------------------------------');

    sumOfResults = angry + disgust + fear + happy + neutral + sad + surprise;
  }
}
