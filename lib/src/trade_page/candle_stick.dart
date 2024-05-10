import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

class CandleStick extends StatefulWidget {
  const CandleStick({super.key});

  @override
  State<CandleStick> createState() => _CandleStickState();
}

class _CandleStickState extends State<CandleStick> {
  List<Candle> candles = [];
  bool themeIsDark = false;

  @override
  void initState() {
    fetchCandles().then((value) {
      setState(() {
        candles = value;
      });
    });
    super.initState();
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1h");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 320,
        decoration: BoxDecoration(
          color: buttonbg,
        ),
        child: Candlesticks(
          candles: candles,
        ),
      ),
    );
  }
}
