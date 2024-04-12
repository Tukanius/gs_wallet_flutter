import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_score/components/score_status_card/bar_data.dart';
import 'package:green_score/widget/ui/color.dart';

class MyBarGraph extends StatefulWidget {
  final List weeklySum;
  const MyBarGraph({Key? key, required this.weeklySum}) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  int selectedIndex = -1;

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
        titlesData: FlTitlesData(show: false),
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: greentext,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toInt() == 1 ? '0' : '${rod.toY.toInt()}',
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
                selectedIndex = -1;
              }
            });
          },
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
                    color: entry.key == selectedIndex ? greentext : barColor,
                    width: 20,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
