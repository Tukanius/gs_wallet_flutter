import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/widget/ui/color.dart';

class MyBarGraph extends StatefulWidget {
  final List weeklySum;
  final Accumlation data;
  const MyBarGraph({
    Key? key,
    required this.weeklySum,
    required this.data,
  }) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  int selectedIndex = -1;
  late List<String> weekDays;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.weeklySum.length - 1;
    weekDays = generateWeekDays();
  }

  List<String> generateWeekDays() {
    List<String> days = ['да', 'мя', 'лх', 'пү', 'ба', 'бя', 'ня'];
    DateTime now = DateTime.now();
    List<String> result = [];

    for (int i = 6; i >= 0; i--) {
      int dayIndex = (now.subtract(Duration(days: i)).weekday - 1) % 7;
      result.add(days[dayIndex]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sun1: widget.weeklySum[0],
      sun2: widget.weeklySum[1],
      sun3: widget.weeklySum[2],
      sun4: widget.weeklySum[3],
      sun5: widget.weeklySum[4],
      sun6: widget.weeklySum[5],
      sun7: widget.weeklySum[6],
    );
    myBarData.initBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                String text = weekDays[value.toInt()];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipBgColor: Colors.green,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()}',
                TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
          touchCallback:
              (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
            setState(() {
              if (barTouchResponse != null && barTouchResponse.spot != null) {
                selectedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              } else {
                selectedIndex = widget.weeklySum.length - 1;
              }
            });
          },
          handleBuiltInTouches: true,
        ),
        barGroups: myBarData.barData
            .asMap()
            .entries
            .map(
              (entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.y,
                    color:
                        entry.key == selectedIndex ? Colors.green : Colors.grey,
                    width: 37,
                    borderRadius: BorderRadius.circular(26),
                  )
                ],
                showingTooltipIndicators: selectedIndex == entry.key ? [0] : [],
              ),
            )
            .toList(),
      ),
    );
  }
}

class BarData {
  final double sun1, sun2, sun3, sun4, sun5, sun6, sun7;
  late List<BarDataModel> barData;

  BarData({
    required this.sun1,
    required this.sun2,
    required this.sun3,
    required this.sun4,
    required this.sun5,
    required this.sun6,
    required this.sun7,
  });

  void initBarData() {
    barData = [
      BarDataModel(y: sun1),
      BarDataModel(y: sun2),
      BarDataModel(y: sun3),
      BarDataModel(y: sun4),
      BarDataModel(y: sun5),
      BarDataModel(y: sun6),
      BarDataModel(y: sun7),
    ];
  }
}

class BarDataModel {
  final double y;
  BarDataModel({required this.y});
}
