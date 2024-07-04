import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/Screens/loginscreen/cubit/state.dart';
import '../../../compenets/cashe_helper.dart';
import '../../../compenets/constants.dart';

class socialloginCubit extends Cubit<LoginState> {
  socialloginCubit() : super(LoginInitial());

  Future<void> LoginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoading());
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((values) {
        uid = values.user!.uid;
       // print(uid);
       // pri

        CollectionReference data =
            FirebaseFirestore.instance.collection('users');
        data.where("uId", isEqualTo: uid).get().then((value) {
          value.docs.forEach((element) {
            name = element.get('name');
             CacheHelper.saveData(key: 'Login', value:true);


            CacheHelper.saveData(key: 'name', value: name);
            CacheHelper.saveData(key: 'email', value: email);
            if (element.get('isAdmin') == true) {
              isAdmin = true;
              adminWidget();
              emit(IsAdmin());
            } else {
              CollectionReference attend =
                  FirebaseFirestore.instance.collection('attendance');
              attend.where("uId", isEqualTo: uid).get().then((value) {
                value.docs.forEach((element) {
                  var x = element.get("count");
                  x++;

                  attend.doc(uid).update({"count": x});
                });
              });
              //userEmail=email;
              adminWidget();
              emit(LoginSuccess());
            }
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user'));
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        emit(LoginFailure(errorMessage: 'Invalid Email or Password'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }
}

Widget adminWidget() {
  if (isAdmin == true) {
    print(isAdmin);
    return const Text('pdf');
  } else {
    print(isAdmin);

    return const Text('quiz');
  }
}

