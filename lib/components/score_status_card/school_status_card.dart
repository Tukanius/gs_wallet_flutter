import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/widget/ui/color.dart';

class SchoolCard extends StatefulWidget {
  final bool isConnected;
  final String assetPath;
  const SchoolCard({
    super.key,
    required this.isConnected,
    required this.assetPath,
  });

  @override
  State<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> with AfterLayoutMixin {
  bool isLoading = false;
  Accumlation schoolCard = Accumlation();
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      schoolCard.type = "COMMUNITY";
      schoolCard.code = "SCHOOL";
      schoolCard = await ScoreApi().getStep(schoolCard);
      print('=======+TEST=======');
      print(schoolCard);
      print('=======+TEST=======');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    widget.assetPath,
                    height: 22,
                    width: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Сургуулийн карт',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Text(
              //               'Картны төрөл',
              //               style: TextStyle(
              //                 color: white,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               '-',
              //               style: TextStyle(
              //                 color: white,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           width: 8,
              //         ),
              //         ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Image.asset(
              //             'assets/images/umoney.jpg',
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoading == true
                    ? '-GS'
                    : schoolCard.balanceAmount == null
                        ? '0GS'
                        : '${schoolCard.balanceAmount}GS',
                style: TextStyle(
                  color: greentext,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Картын дугаар',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                '---- ---- ---- ----',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
