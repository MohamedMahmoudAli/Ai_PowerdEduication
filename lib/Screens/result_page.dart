import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hieroglyphic_app/Screens/home_screen/home_screen.dart';
import 'package:hieroglyphic_app/compenets/constants.dart';

import '../compenets/constant/colors.dart';
import '../widgets/app_color.dart';
import '../widgets/income_chart.dart';
import '../widgets/indicator.dart';

class ResultPage extends StatefulWidget {
   ResultPage({super.key,});
 // final  id;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
@override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(AppLocalizations.of(context)!.reslutPage),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(

                  ),
                ));
          },
        ),
      ),


      body:isAdmin?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 250,width: 300,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingTotalSections(),
                ),
              ),
            ),
            const SizedBox(height: 30,),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 60,vertical: 4),
          leading: Container(
            width: 20,
            height: 20,
            decoration: const ShapeDecoration(
              color: Color(0xFF208BC7),
              shape: OvalBorder(),
            ),
          ),
          title: Text(
            'angry',
          ),

        ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF4DB7F2),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'happy',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF064060),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'sad',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFFb388eb),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'disgust',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xff023e8a),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'fear',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF3c099c),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'surprise',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color:Color(0xFFE2DECD),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'neutral',
                // style: AppStyles.styleRegular16(context),
              ),

            ),

          ],
        ),
      ): SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 250,width: 300,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: const ShapeDecoration(
                  color: Color(0xFF208BC7),
                  shape: OvalBorder(),
                ),
              ),
              title: Text(
                'angry',
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF4DB7F2),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'happy',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF064060),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'sad',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFFb388eb),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'disgust',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xff023e8a),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'fear',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: Color(0xFF3c099c),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'surprise',
                // style: AppStyles.styleRegular16(context),
              ),

            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 4),
              leading: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color:Color(0xFFE2DECD),
                  shape: const OvalBorder(),
                ),
              ),
              title: Text(
                'neutral',
                // style: AppStyles.styleRegular16(context),
              ),

            ),

          ],
        ),
      )

    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xFF4DB7F2),
            value: ((happy / sumOfResults) * 100).truncate().toDouble(),
            title: '${((happy / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xFF064060),
            value:((sad / sumOfResults) * 100).truncate().toDouble(),
            title: '${((sad / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color:  Color(0xFF3c099c),
            value: ((fear / sumOfResults) * 100).truncate().toDouble(),
            title: '${((fear / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xFF208BC7),
            value: ((angry / sumOfResults) * 100).truncate().toDouble(),
            title: '${((angry / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Color(0xFFb388eb),
            value: ((disgust / sumOfResults) * 100).truncate().toDouble(),
            title: '${((disgust / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color:Color(0xFFE2DECD),
            value: ((neutral / sumOfResults) * 100).truncate().toDouble(),
            title: '${((neutral / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 6:
          return PieChartSectionData(
            color: Color(0xFFb388eb),
            value: ((surprise / sumOfResults) * 100).truncate().toDouble(),
            title: '${((surprise / sumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingTotalSections() {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xFF4DB7F2),
            value: ((totalhappy / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totalhappy / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xFF064060),
            value:((totalsad / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totalsad / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color:  Color(0xFF3c099c),
            value: ((totaleFear / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totaleFear / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xFF208BC7),
            value: ((totalangry / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totalangry / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Color(0xFFb388eb),
            value: ((totaldisgust / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totaldisgust / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color:Color(0xFFE2DECD),
            value: ((totalneutral / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totalneutral / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:  Colors.white,
              shadows: shadows,
            ),
          );
        case 6:
          return PieChartSectionData(
            color: Color(0xFFb388eb),
            value: ((totalsurprise / totalsumOfResults) * 100).truncate().toDouble(),
            title: '${((totalsurprise / totalsumOfResults) * 100).truncate()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

}
