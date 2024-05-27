import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class NotificationCard extends StatefulWidget {
  final bool isVisit;
  final Function() onClick;
  const NotificationCard({
    super.key,
    required this.isVisit,
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
        height: 98,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: widget.isVisit == false ? transparent : buttonbg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 52,
                    width: 52,
                    child: Image.asset(
                      'assets/images/asus.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Asus',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Шинээр дэлгүүр нэмэгдлээ',
                      style: TextStyle(
                        color: greytext,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SvgPicture.asset('assets/svg/not_forward.svg'),
          ],
        ),
      ),
    );
  }
}
