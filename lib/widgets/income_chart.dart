
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constants.dart';

import '../compenets/constants.dart';

class IncomeChart extends StatefulWidget {
   IncomeChart({super.key, required this.happy,
     required this.sad, required this.neutral, required this.angry,
     required this.fear, required this.disgust, required this.surprise, required this.totalsumOfResults});


final num happy,sad,neutral,angry,
    fear,disgust,surprise,totalsumOfResults;
  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  int activeIndex = -1;



  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(getChartData()),
    );
  }

  PieChartData getChartData() {
    double width = MediaQuery.of(context).size.width;

    return PieChartData(
      centerSpaceRadius:width>800 && width<1200 ? 90:52,
      pieTouchData: PieTouchData(
        enabled: true,
        touchCallback: (p0, pietouchResponse) {
          activeIndex =
              pietouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
          setState(() {});
        },
      ),
      sectionsSpace: 0,
      sections: [
        PieChartSectionData(
          showTitle: false,
          value: ((widget.sad / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 0 ? 60 : 50,
          color: const Color(0xFF208BC7),
        ),
        PieChartSectionData(
          value: ((widget.happy / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 1 ? 60 : 50,
          showTitle: false,
          color: const Color(0xFF4DB7F2),
        ),
        PieChartSectionData(
          value: ((widget.angry / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 2 ? 60 : 50,
          showTitle: false,
          color: const Color(0xFF064060),
        ),
        PieChartSectionData(
          value:((widget.neutral / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 3 ? 60 : 50,
          showTitle: false,
          color: const Color(0xFFE2DECD),
        ),
        PieChartSectionData(
          value: ((widget.disgust / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 4 ? 60 : 50,
          showTitle: false,
          color: const Color(0xff023e8a),
        ),
        PieChartSectionData(
          value:((widget.fear / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 5 ? 60 : 50,
          showTitle: false,
          color: const Color(0xFF3c099c),
        ),
        PieChartSectionData(
          value: ((widget.surprise / widget.totalsumOfResults) * 100).truncate().toDouble(),
          radius: activeIndex == 6 ? 60 : 50,
          showTitle: false,
          color: const Color(0xFFb388eb),
        ),
      ],
    );
  }
}
