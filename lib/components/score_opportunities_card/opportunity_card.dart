import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';

class OpportunityCard extends StatefulWidget {
  final String id;
  final String assetPath;
  final String title;
  final String subtitle;
  final Function()? onClick;

  const OpportunityCard({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.subtitle,
    this.onClick,
    required this.id,
  }) : super(key: key);

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onClick,
          hoverColor: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: buttonbg,
                        ),
                        child: Center(
                          child: SvgPicture.asset(widget.assetPath),
                        ),
                      ),
                      widget.id == "2"
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Lottie.asset(
                                'assets/lottie/live.json',
                                fit: BoxFit.cover,
                                height: 25,
                                width: 25,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: colortext,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/svg/icon_button.svg',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
