// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hieroglyphic_app/Screens/loginscreen/cubit/state.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../compenets/cashe_helper.dart';
// import '../../compenets/constants.dart';
// import '../register_screen/register_screen.dart';
//
// class socialloginCubit extends Cubit<LoginState> {
//   socialloginCubit() : super(LoginInitial());
//
//   Future uploadFile() async {
//     final path = 'files/${PickedFile!.name}';
//     final file = File(PickedFile!.path!);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     ref.putFile(file);
//     String Imageurl = await ref.getDownloadURL();
//     print(Imageurl);
//     print("=====================");
//
//     // final snapshot = await uploadTask!.whenComplete(() {});
//     // final urlDownload = await snapshot.ref.getDownloadURL();
//     // print("Download link is :$urlDownload");
//   }
//
//   Future SelectFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     setState(() {
//       PickedFile = result!.files.first;
//     });
//   }
//
//   Future<void> LoginUser(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     emit(LoginLoading());
//     try {
//       var user = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((values) {
//         uid = values.user!.uid;
//        // print(uid);
//
//         FirebaseFirestore.instance
//             .collection('files')
//             .add({'name': ''});
//
//         CollectionReference files =
//             FirebaseFirestore.instance.collection('files');
//         files.where("uId", isEqualTo: uid).get().then((value) {
//           value.docs.forEach((element) {
//             print(element.data());
//
//             name = element.get('name');
//             CacheHelper.saveData(key: 'name', value: name);
//             print('#######################');
//             print(element.get('isAdmin'));
//             print('#######################');
//             if (element.get('isAdmin') == true) {
//               emit(IsAdmin());
//             } else {
//               CollectionReference attend =
//                   FirebaseFirestore.instance.collection('attendance');
//               attend.where("uId", isEqualTo: uid).get().then((value) {
//                 value.docs.forEach((element) {
//                   var x = element.get("count");
//                   x++;
//
//                   attend.doc(uid).update({"count": x});
//                 });
//               });
//               emit(LoginSuccess());
//             }
//           });
//         });
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         emit(LoginFailure(errorMessage: 'No user found for that email'));
//       } else if (e.code == 'wrong-password') {
//         emit(LoginFailure(
//             errorMessage: 'Wrong password provided for that user'));
//       } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
//         emit(LoginFailure(errorMessage: 'Invalid Email or Password'));
//       }
//     } catch (e) {
//       emit(LoginFailure(errorMessage: 'Something went wrong'));
//     }
//   }
// }
