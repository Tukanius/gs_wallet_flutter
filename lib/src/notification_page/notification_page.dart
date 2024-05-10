import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/notification_card/notification_card.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = "NotificationPage";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              pinned: false,
              snap: true,
              floating: true,
              elevation: 0,
              backgroundColor: transparent,
              leading: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomBackButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                'Мэдэгдэл',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                SvgPicture.asset('assets/svg/more.svg'),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [true, false, false, true, true]
                .map(
                  (e) => Column(
                    children: [
                      NotificationCard(
                        isVisit: e,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
