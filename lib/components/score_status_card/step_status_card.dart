import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/auth_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/score_status_card/bar_data/bar_graph.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/loading_provider.dart';
import 'package:green_score/provider/socket_provider.dart';
import 'package:green_score/provider/tools_provider.dart';
import 'package:green_score/src/profile_page/dan_verify_page/dan_verify_page.dart';
import 'package:green_score/src/score_page/collect_score_page/collect_step_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StepStatusCard extends StatefulWidget {
  final bool? isActive;
  final String assetPath;
  final String pushWhere;
  const StepStatusCard({
    super.key,
    required this.assetPath,
    this.isActive,
    required this.pushWhere,
  });

  @override
  State<StepStatusCard> createState() => _StepStatusCardState();
}

class _StepStatusCardState extends State<StepStatusCard> with AfterLayoutMixin {
  User user = User();
  bool isLoading = false;
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      user = await AuthApi().me(false);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading =
        Provider.of<LoadingProvider>(context, listen: false).isLoading;
    final stepped = Provider.of<ToolsProvider>(context, listen: false);
    final socket = Provider.of<SocketProvider>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              widget.isActive == true
                  ? Row(
                      children: [
                        Lottie.asset(
                          'assets/lottie/live.json',
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : SizedBox(),
              SvgPicture.asset(
                '${widget.assetPath}',
                height: 36,
                width: 36,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Алхалт',
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    loading == true
                        ? '0'
                        : '${Provider.of<ToolsProvider>(context).stepped}',
                    style: TextStyle(
                      color: white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 120,
            child: MyBarGraph(
              weeklySum: Provider.of<ToolsProvider>(context, listen: true)
                  .stepsForLast7Days,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          isLoading == true
              ? CustomButton(
                  labelText: 'Урамшуулал татах',
                  height: 40,
                  textColor: white,
                  buttonColor: greytext,
                  isLoading: false,
                  onClick: () {},
                )
              : CustomButton(
                  labelText: 'Урамшуулал татах',
                  height: 40,
                  textColor: white,
                  buttonColor: loading == true
                      ? greytext
                      : stepped.threshold <= stepped.stepped &&
                              stepped.threshold != 0
                          ? greentext
                          : greytext,
                  isLoading: loading == true
                      ? false
                      : stepped.threshold <= stepped.stepped &&
                              stepped.threshold != 0
                          ? loading
                          : false,
                  onClick: loading == true
                      ? () {}
                      : stepped.threshold <= stepped.stepped &&
                              stepped.threshold != 0
                          ? () async {
                              if (stepped.threshold <= stepped.stepped &&
                                  stepped.threshold != 0) {
                                print('======stepped.stepped====');
                                print(stepped.stepped);
                                print(stepped.accumulatedSteps);
                                print(stepped.id);
                                print('======stepped.stepped====');
                                if (stepped.accumulatedSteps != 0) {
                                  socket.sendStep(
                                      stepped.accumulatedSteps, 0, 0);
                                  print('========');
                                }
                                stepped.accumulatedSteps = 0;
                                if (user.danVerified == false) {
                                  Navigator.of(context)
                                      .pushNamed(DanVerifyPage.routeName);
                                } else {
                                  Navigator.of(context).pushNamed(
                                    CollectStepScore.routeName,
                                    arguments: CollectStepScoreArguments(
                                      id: stepped.id,
                                      pushWhere: widget.pushWhere,
                                    ),
                                  );
                                }
                              }
                            }
                          : () {},
                ),
        ],
      ),
    );
  }
}
