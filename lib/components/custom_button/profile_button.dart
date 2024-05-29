import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class ProfileButton extends StatefulWidget {
  final Function()? onClick;
  final String text;
  final String svgPath;
  final bool? isVerify;
  ProfileButton({
    this.onClick,
    Key? key,
    required this.text,
    required this.svgPath,
    this.isVerify,
  }) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: buttonbg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  widget.svgPath,
                  // ignore: deprecated_member_use
                  color: widget.isVerify == true ? greentext : white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.text}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: white,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
