import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/notify.dart';
import 'package:green_score/widget/ui/color.dart';

class NotificationCard extends StatefulWidget {
  // final bool isVisit;
  final Notify data;
  final Function() onClick;
  const NotificationCard({
    super.key,
    required this.data,
    required this.onClick,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: widget.data.seen == false ? buttonbg : transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 52,
                      width: 52,
                      child: Image.asset(
                        'assets/icon/icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    //     Container(
                    //   height: 52,
                    //   width: 52,
                    //   child: Image.asset(
                    //     'assets/icon/icon.png',
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data.title}",
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.data.body}",
                          style: TextStyle(
                            color: greytext,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/svg/not_forward.svg'),
          ],
        ),
      ),
    );
  }
}
