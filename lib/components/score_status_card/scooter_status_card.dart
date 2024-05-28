import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/collect_score_page/collect_score_page/collect_scooter_page.dart';
import 'package:green_score/widget/ui/color.dart';

class ScooterStatusCard extends StatefulWidget {
  final String assetPath;

  const ScooterStatusCard({
    super.key,
    required this.assetPath,
  });

  @override
  State<ScooterStatusCard> createState() => _ScooterStatusCardState();
}

class _ScooterStatusCardState extends State<ScooterStatusCard>
    with AfterLayoutMixin {
  Accumlation scooter = Accumlation();

  bool isLoading = true;
  bool isButtonLoad = false;
  Deposit getData = Deposit();
  bool show = false;

  @override
  afterFirstLayout(BuildContext context) async {
    await _getWalk();
  }

  _getWalk() async {
    try {
      setState(() {
        isButtonLoad = true;
      });
      scooter.type = "COMMUNITY";
      scooter.code = "SCOOTER_01";
      scooter = await ScoreApi().getStep(scooter);
      getData = await ScoreApi().redeemCalculate(scooter.id!);

      setState(() {
        isButtonLoad = false;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isButtonLoad = false;

        isLoading = false;
      });
      print(e.toString());
    }
  }

  comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bg,
          content: Text(
            'Тун удахгүй!',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        '${widget.assetPath}',
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Скүүтер',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    isLoading == true
                        ? '-GS'
                        : getData.amount == null
                            ? '0GS'
                            : '${getData.amount}GS',
                    style: TextStyle(
                      color: greentext,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/images/tapa.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset('assets/images/jet.png'),
                ],
              ),
            ],
          ),
          show == true
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    border: Border.all(color: red),
                  ),
                  child: Center(
                    child: Text(
                      'Урамшуулал авах боломжгүй байна.',
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SizedBox(),
          CustomButton(
            circular: 100,
            labelText: 'Урамшуулал авах',
            height: 40,
            buttonColor: greentext,
            isLoading: false,
            onClick: () {
              scooter.isRedeem == true
                  ? Navigator.of(context).pushNamed(
                      CollectScooterScore.routeName,
                      arguments: CollectScooterScoreArguments(id: scooter.id!),
                    )
                  : setState(() {
                      show = true;
                    });
            },
            textColor: white,
          ),
        ],
      ),
    );
  }
}
