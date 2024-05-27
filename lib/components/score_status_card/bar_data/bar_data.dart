import 'package:green_score/components/score_status_card/bar_data/bar_config.dart';

class BarData {
  final double sun1;
  final double sun2;
  final double sun3;
  final double sun4;
  final double sun5;
  final double sun6;
  final double sun7;
  BarData({
    required this.sun1,
    required this.sun2,
    required this.sun3,
    required this.sun4,
    required this.sun5,
    required this.sun6,
    required this.sun7,
  });
  List<IndiBar> barData = [];

  void initBarData() {
    barData = [
      IndiBar(x: 0, y: sun1),
      IndiBar(x: 1, y: sun2),
      IndiBar(x: 2, y: sun3),
      IndiBar(x: 3, y: sun4),
      IndiBar(x: 4, y: sun5),
      IndiBar(x: 5, y: sun6),
      IndiBar(x: 6, y: sun7),
    ];
  }
}
