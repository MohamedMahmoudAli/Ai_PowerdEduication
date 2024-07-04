
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// class testApi extends StatefulWidget {
//   static const String routeName = 'test image';
//
//   @override
//   _testApiState createState() => _testApiState();
// }
//
// class _testApiState extends State<testApi> {
//   bool loading = true;
//   late File _image;
//   late Map<String, dynamic> _output;
//   final imagepicker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> detectImage(File image) async {
//     setState(() {
//      loading = true;
//     });
//
//     final API_URL =
//         "https://api-inference.huggingface.co/models/Rajaram1996/FacialEmoRecog";
//     final headers = {
//       "Authorization":
//       "Bearer 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",
//       "Content-Type": "application/json"
//     };
//
//     List<int> imageBytes = await image.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//
//     final Map<String, dynamic> data = {"inputs": base64Image};
//
//     final response = await http.post(
//       Uri.parse(API_URL),
//       headers: headers,
//       body: json.encode(data),
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         _output = json.decode(response.body);
//         loading = false;
//       });
//     } else {
//       setState(() {
//         _output = {};
//         loading = false;
//       });
//       print('Error: ${response.statusCode}');
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<void> pickImageCamera() async {
//     var image = await imagepicker.pickImage(source: ImageSource.camera);
//     if (image == null) {
//       return null;
//     } else {
//       _image = File(image.path);
//     }
//     await detectImage(_image);
//   }
//
//   Future<void> pickImageGallery() async {
//     var image = await imagepicker.pickImage(
//       source: ImageSource.gallery,
//       maxHeight: 224,
//       maxWidth: 224,
//     );
//     if (image == null) {
//       return null;
//     } else {
//       _image = File(image.path);
//     }
//     await detectImage(_image);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'ML Classifier',
//           ),
//         ),
//         body: SizedBox(
//             height: h,
//             width: w,
//             child: Column(
//               children: [
//                 //... Your existing UI widgets ...
//
//                 // Capture Button
//                 ElevatedButton(
//                   child: Text('Capture'),
//                   onPressed: () {
//                     pickImageCamera();
//                   },
//                 ),
//
//                 SizedBox(height: 10),
//
//                 // Gallery Button
//                 ElevatedButton(
//                   child: Text('Gallery'),
//                   onPressed: () {
//                     pickImageGallery();
//                   },
//                 ),
//
//                 //... Rest of your UI ...
//
//                 // Display Results
//                 if (!loading)
//                   Column(
//                     children: [
//                       // Display Image
//                       _image != null
//                           ? Image.file(
//                         _image,
//                         height: 220,
//                       )
//                           : Container(),
//
//                       // Display Output
//                       _output != null
//                           ? Text(
//                         '${_output['label']}',
//                         style: TextStyle(fontSize: 18),
//                       )
//                           : Text(''),
//                     ],
//                   ),
//                 if (loading)
//                   Container(
//                     child: CircularProgressIndicator(),
//                   ),
//               ],
//             ),
//             ),
//         );
//   }
// }


























// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
//
// class testApi extends StatefulWidget {
//   @override
//   _testApiState createState() => _testApiState();
// }
//
// class _testApiState extends State<testApi> {
//    Future<String>? _response;
//
//   Future<String> getResponseFromAIModel(String query) async {
//     // Replace with your actual AI model endpoint
//     final String url = 'https://your-ai-model-endpoint.com';
//
//     final response = await http.post(
//       Uri.parse(url),
//       body: {"query": query},
//     );
//
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       throw Exception('Failed to load response from AI model');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('AI Model Flutter App'),
//         ),
//         body: Column(
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     _response = getResponseFromAIModel(value);
//                   });
//                 },
//               ),
//               FutureBuilder<String>(
//                 future: _response,
//                 builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!);
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//
//                   return CircularProgressIndicator();
//                 },
//               ),
//             ],
//            ),
//         );
//     }
// }