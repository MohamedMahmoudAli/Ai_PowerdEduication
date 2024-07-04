import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hieroglyphic_app/Screens/loginscreen/loginscreen.dart';
import 'package:hieroglyphic_app/compenets/cashe_helper.dart';
import 'package:hieroglyphic_app/compenets/components.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  final String text;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
    required this.text,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/svg/onboardingImage1.svg',
      text: 'Welcome to DWD',
      title: 'Welcome to DWD',
      body: 'Welcome as you learn a world changing skill to get a better job.',
    ),
    BoardingModel(
      image: 'assets/svg/onboardingImage2.svg',
      text: "Choose Your Course",
      title: "Choose Your Course",
      body:
          "Choose the course of your choice and gain industry knowledge and experience in it.",
    ),
    BoardingModel(
      image: 'assets/svg/onboardingImage3.svg',
      text: "Get Certified",
      title: "Get Certified",
      body:
          "Start learning and get certified after your training to get a lucrative job",
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: submit,
              child:  Text(
                "Skip",
                style: TextStyle(
                  color: AppColor.primaryColor,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect:  ExpandingDotsEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: AppColor.primaryColor,
                    radius: 20.0,
                    spacing: 6,
                    expansionFactor: 4.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  child:  Icon(
                    Icons.play_arrow_outlined,
                    size: 35.0,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 780,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 200,
              child: SvgPicture.asset(
                model.image,
                fit: BoxFit.contain,
              )),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  model.title,
                  style:  TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10),
                  child: Text(
                    model.body,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
