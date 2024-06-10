import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class CustomBackButton extends StatefulWidget {
  final Function()? onClick;
  const CustomBackButton({super.key, this.onClick});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        color: transparent,
        child: Center(
          child: SvgPicture.asset('assets/svg/arrow_back.svg'),
        ),
      ),
    );
  }
}
