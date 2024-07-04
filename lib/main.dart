import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hieroglyphic_app/Screens/chat_page/chat_cubit.dart';
import 'package:hieroglyphic_app/Screens/register_screen/register_screen.dart';
import 'package:hieroglyphic_app/Screens/result_page.dart';
import 'package:hieroglyphic_app/Screens/loginscreen/loginscreen.dart';
import 'package:hieroglyphic_app/Screens/pdf/pdf.dart';
import 'package:hieroglyphic_app/Screens/pdf_screen/pdf_cubit.dart';
import 'package:hieroglyphic_app/Screens/zoom/join_with_code.dart';
import 'package:hieroglyphic_app/compenets/cashe_helper.dart';
import 'package:hieroglyphic_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:hieroglyphic_app/screens/home_screen/home_screen.dart';
import 'package:hieroglyphic_app/screens/onBoarding_Screen.dart';
import 'Screens/pdf_screen/lecture_screen.dart';
import 'Screens/quiz_screens/quiz_screen.dart';
import 'Screens/zoom/new_meeting.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/quiz_model/db_connect.dart';

List<CameraDescription>? camera;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  camera = await availableCameras();
  await CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? Login = CacheHelper.getData(key: 'Login');

 // print(Login);

  if (onBoarding != null) {
    if (Login == true) {
      widget = HomeScreen(
      );
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }


  var db = DBconnect();

  db.fetchQuestions();

  
  
 // print(widget);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(),),
        BlocProvider(create: (context) => ChatCubit(),),
        BlocProvider(create: (context) => PdfCubit()),

      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return MaterialApp(

              title: 'Flutter Demo',
              localizationsDelegates: const [
                AppLocalizations.delegate, // Add this line

              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // arabic
            ],
            locale: cubit.isEnglish ? Locale('en') : Locale('ar'),
            debugShowCheckedModeBanner: false,

            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,

            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              LectureScreen.routeName: (context) =>  LectureScreen(),
              Pdf.routeName: (context) => Pdf(),
              JoinWithCode.routeName: (context) => JoinWithCode(),
              NewMeeting.routeName: (context) => NewMeeting(),

            },
            home: startWidget,
          );
        },
      ),
      // initialRoute:HomeScreen.routeName ,
    );
  }
}


