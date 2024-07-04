// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
//
// class TestCamera extends StatefulWidget {
//   static const String routeName='test';
//
//   @override
//   _TestCameraState createState() => _TestCameraState();
// }
//
// class _TestCameraState extends State<TestCamera> {
//   bool loading = true;
//   late File _image;
//   late List _output;
//   final imagepicker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     loadmodel().then((value) {
//       setState(() {});
//     });
//   }
//
//   detectimage(File image) async {
//     var prediction = await Tflite.runModelOnImage(
//         path: image.path,
//         numResults: 2,
//         threshold: 0.6,
//         imageMean: 127.5,
//         imageStd: 127.5,asynch: true);
//
//     setState(() {
//       _output = prediction!;
//       loading = false;
//     });
//   }
//
//   loadmodel() async {
//     await Tflite.loadModel(
//         model: 'assets/models/model3.tflite', labels: 'assets/models/labels1.txt');
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   pickimage_camera() async {
//     var image = await imagepicker.pickImage(source: ImageSource.camera);
//     if (image == null) {
//       return null;
//     } else {
//       _image = File(image.path);
//     }
//     detectimage(_image);
//   }
//
//   pickimage_gallery() async {
//     var image = await imagepicker.pickImage(source: ImageSource.gallery,maxHeight: 224,maxWidth: 224, );
//     if (image == null) {
//       return null;
//     } else {
//       _image = File(image.path);
//     }
//     detectimage(_image);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'ML Classifier',
//           style: GoogleFonts.roboto(),
//         ),
//       ),
//       body: SizedBox(
//         height: h,
//         width: w,
//         child: Column(
//           children: [
//             Container(
//               height: 150,
//               width: 150,
//               padding: const EdgeInsets.all(10),
//               child: Image.asset('assets/images/Robot.jpg'),
//             ),
//             Text('Mask Detector',
//                 style: GoogleFonts.roboto(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 )),
//             const SizedBox(height: 50),
//             Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     // color: Colors.teal[800],
//                     // shape: RoundedRectangleBorder(
//                     //     borderRadius: BorderRadius.circular(10)),
//                       child: Text('Capture',
//                           style: GoogleFonts.roboto(fontSize: 18)),
//                       onPressed: () {
//                         pickimage_camera();
//                       }),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     // color: Colors.teal[800],
//                     // shape: RoundedRectangleBorder(
//                     //     borderRadius: BorderRadius.circular(10)),
//                       child: Text('Gallery',
//                           style: GoogleFonts.roboto(fontSize: 18)),
//                       onPressed: () {
//                         pickimage_gallery();
//                       }),
//                 ),
//               ],
//             ),
//             loading != true
//                 ? Column(
//               children: [
//                 Container(
//                   height: 220,
//                   // width: double.infinity,
//                   padding: const EdgeInsets.all(15),
//                   child: Image.file(_image),
//                 ),
//                 _output != null
//                     ? Text(
//                     (_output[0]['label']).toString().substring(2),
//                     style: GoogleFonts.roboto(fontSize: 18))
//                     : const Text(''),
//                 _output != null
//                     ? Text(
//                     'Confidence: ${_output[0]['confidence']}',
//                     style: GoogleFonts.roboto(fontSize: 18))
//                     : const Text('')
//               ],
//             )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }
