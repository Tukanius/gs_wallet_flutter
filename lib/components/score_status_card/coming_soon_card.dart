import 'package:flutter/material.dart';
import 'package:green_score/widget/ui/color.dart';

class ComingSoonCard extends StatefulWidget {
  const ComingSoonCard({super.key});

  @override
  State<ComingSoonCard> createState() => _ComingSoonCardState();
}

class _ComingSoonCardState extends State<ComingSoonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Center(
        child: Text(
          'Тун удахгүй.',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
