import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/Screens/loginscreen/loginscreen.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';

import 'package:meta/meta.dart';

import '../../../compenets/cashe_helper.dart';
import '../../../compenets/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
static HomeCubit get(context)=>BlocProvider.of(context);
int currentIndex=0;

List<Widget> bottomWidget=[

  Column(

    children: [
      Icon(Icons.menu_book_sharp,color: Colors.white,),
      Text('Lectures  ',style: TextStyle(color: Colors.white,fontSize: 12),),
    ],
  ),
  // Column(
  //   children: [
  //     Icon(Icons.list,color: Colors.white,),
  //     Text('List',style: TextStyle(color: Colors.white),),
  //   ],
  // ),
  // Column(
  //   children: [
  //     Icon(Icons.more_vert,color: Colors.white,),
  //     Text('Test Camera',style: TextStyle(color: Colors.white),),
  //   ],
  // ),
  Column(
    children: [

       Icon(
         Icons.bookmark_add,

         color: Colors.white,),

      Text('Pdf',
        style: TextStyle(color: Colors.white,fontSize: 12),),


    ],
  ),
  Column(
    children: [
      Icon(Icons.videocam,color: Colors.white,),
      Text('Metting',style: TextStyle(color: Colors.white,fontSize: 12),),
    ],
  ),
  Column(
    children: [
      Icon(Icons.chat_rounded,color: Colors.white,),
      Text('Chat',style: TextStyle(color: Colors.white),),
    ],
  ),
];


List<Widget> bottomWidgetUser=[

  Column(

    children: [
      Icon(Icons.menu_book_sharp,color: Colors.white,),
      Text('Lectures  ',style: TextStyle(color: Colors.white,fontSize: 12),),
    ],
  ),
  // Column(
  //   children: [
  //     Icon(Icons.list,color: Colors.white,),
  //     Text('List',style: TextStyle(color: Colors.white),),
  //   ],
  // ),
  // Column(
  //   children: [
  //     Icon(Icons.more_vert,color: Colors.white,),
  //     Text('Test Camera',style: TextStyle(color: Colors.white),),
  //   ],
  // ),
  Column(
    children: [

       Icon(
         Icons.quiz,

         color: Colors.white,),

      Text('Quiz',
        style: TextStyle(color: Colors.white,fontSize: 12),),


    ],
  ),
  Column(
    children: [
      Icon(Icons.videocam,color: Colors.white,),
      Text('Metting',style: TextStyle(color: Colors.white,fontSize: 12),),
    ],
  ),
  Column(
    children: [
      Icon(Icons.chat_rounded,color: Colors.white,),
      Text('Chat',style: TextStyle(color: Colors.white),),
    ],
  ),
];

void changeBottomNavBar(int index,BuildContext context){
  currentIndex=index;
  emit(HomeBottomNavBar());
}


var isDark=false;
void changeMode(){

    isDark=!isDark;
if(isDark){
  AppColor.primaryColor=AppColor.darkColor;

}else{
  AppColor.primaryColor=Color(0xff66328E);


}
    emit(ChangeMode());


}

  var isEnglish=false;

void changeLanguage(){
  changeBubble=!isEnglish;
  isEnglish=!isEnglish;
    emit(ChangeLanguage());


}

  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {

      CacheHelper.removeData(key: 'Login');
      isAdmin = false;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => LoginScreen(),)
          , (route) => false);

    //  currentIndex = 0;
      emit(Logout());
    }).catchError((error) {
      emit(LogoutError(error.toString()));
      });
    }




  Future<void> _fetchData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('myCollection').get();
      for (var doc in querySnapshot.docs) {
        print(doc.data());
      }
    } catch (e) {
    print(e);
    }
  }



}
