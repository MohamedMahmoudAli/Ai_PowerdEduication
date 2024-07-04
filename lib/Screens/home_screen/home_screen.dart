import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/Screens/chat_page/chatPage.dart';
import 'package:hieroglyphic_app/Screens/pdf/pdf.dart';
import 'package:hieroglyphic_app/Screens/pdf_screen/lecture_screen.dart';
import 'package:hieroglyphic_app/Screens/quiz_screens/quiz_screen.dart';
import 'package:hieroglyphic_app/Screens/zoom/home_zoom.dart';
import 'package:hieroglyphic_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../compenets/constant/colors.dart';
import '../../compenets/constants.dart';
import '../../widgets/drawer.dart';


import '../test_model/test_camera.dart';
import '../test_real.dart';




class HomeScreen extends StatelessWidget {
  static const String routeName='home';


  @override
  Widget build(BuildContext context) {



    List<String> screensName= [
       AppLocalizations.of(context)!.homeTitle,
        AppLocalizations.of(context)!.pdf,
       AppLocalizations.of(context)!.zoom,
      AppLocalizations.of(context)!.chat,


    ];

    List<String> screensNameUser= [
       AppLocalizations.of(context)!.homeTitle,
        AppLocalizations.of(context)!.quiz,
       AppLocalizations.of(context)!.zoom,
      AppLocalizations.of(context)!.chat,


    ];

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(

                isAdmin?screensName[cubit.currentIndex]:screensNameUser[cubit.currentIndex],),

            backgroundColor: AppColor.primaryColor,
            ),

          drawer: MainDrawer(),

          bottomNavigationBar:
          CurvedNavigationBar(

           // buttonBackgroundColor:  Colors.white ,
            color:AppColor.primaryColor ,
            height: 50,

            backgroundColor: Colors.white.withOpacity(.8),
            items:isAdmin? cubit.bottomWidget:cubit.bottomWidgetUser,
            index: cubit.currentIndex,
            onTap: (index) {
            cubit.changeBottomNavBar(index,context);
            },
          ),
          body:isAdmin?tabs[cubit.currentIndex]:tabs2[cubit.currentIndex],


        );
      },
    );
  }

List<Widget> tabs= [LectureScreen(),Pdf(),HomeZoom(),ChatPage()];
List<Widget> tabs2= [LectureScreen(),QuizScreen(),HomeZoom(),ChatPage()];
}


