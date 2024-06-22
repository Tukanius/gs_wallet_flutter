import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';

class MyBarGraph extends StatefulWidget {
  final List<double> weeklySum;

  const MyBarGraph({
    Key? key,
    required this.weeklySum,
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
    weekDays = generateWeekDays();
    selectedIndex = widget.weeklySum.length - 1;
  }

  List<String> generateWeekDays() {
    List<String> days = ['Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя', 'Ня'];
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
      day1: widget.weeklySum[0],
      day2: widget.weeklySum[1],
      day3: widget.weeklySum[2],
      day4: widget.weeklySum[3],
      day5: widget.weeklySum[4],
      day6: widget.weeklySum[5],
      day7: widget.weeklySum[6],
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
            tooltipBgColor: greentext,
            // tooltipMargin: 20,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()}',
                TextStyle(
                  color: white,
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
                    color: entry.key == selectedIndex ? greentext : greytext,
                    width: 30,
                    borderRadius: BorderRadius.circular(26),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: widget.weeklySum.reduce((value, element) =>
                          element > value ? element : value),
                      color: Colors.transparent,
                    ),
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
  final double day1, day2, day3, day4, day5, day6, day7;
  late List<BarDataModel> barData;

  BarData({
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4,
    required this.day5,
    required this.day6,
    required this.day7,
  });

  void initBarData() {
    barData = [
      BarDataModel(y: day1),
      BarDataModel(y: day2),
      BarDataModel(y: day3),
      BarDataModel(y: day4),
      BarDataModel(y: day5),
      BarDataModel(y: day6),
      BarDataModel(y: day7),
    ];
  }
}

class BarDataModel {
  final double y;
  BarDataModel({required this.y});
}
