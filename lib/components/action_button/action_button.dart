import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class ActionButton extends StatefulWidget {
  final Function()? onClick;
  final String svgAssetPath;

  const ActionButton({
    this.onClick,
    required this.svgAssetPath,
    Key? key,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: buttonbg,
        ),
        child: Center(
          child: SvgPicture.asset(
            widget.svgAssetPath,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
