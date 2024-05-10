import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_score/components/back_button/back_button.dart';
// import 'package:green_score/components/history_card/fiat_history_card.dart';
import 'package:green_score/components/score_status_card/score_status_card.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:nfc_manager/nfc_manager.dart';

class OpportunityStatusPageArguments {
  String id;
  String title;
  String assetPath;

  OpportunityStatusPageArguments({
    required this.id,
    required this.title,
    required this.assetPath,
  });
}

class OpportunityStatusPage extends StatefulWidget {
  final String id;
  final String title;
  final String assetPath;

  static const routeName = "OpportunityStatusPage";
  const OpportunityStatusPage({
    super.key,
    required this.id,
    required this.title,
    required this.assetPath,
  });

  @override
  State<OpportunityStatusPage> createState() => _OpportunityStatusPageState();
}

class _OpportunityStatusPageState extends State<OpportunityStatusPage> {
  void _showNFCBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
            color: white,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: nfc,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        'Карт холбох',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/svg/close.svg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/nfc.jpg',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'UMoney картаа утасныхаа NFC уншигчид хүргэж картыхаа мэдээллийг оруулна уу.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await NfcManager.instance.startSession(
                        onDiscovered: (NfcTag tag) async {
                          print('Tag discovered: ${tag.data}');
                        },
                      );
                    },
                    child: Text('Start NFC Read'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isConnected = false;
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
                '${widget.title}',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScoreStatusCard(
                        assetPath: "${widget.assetPath}",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      widget.id == "1" && isConnected == false
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showNFCBottomSheet(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: buttonbg,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Карт холбох',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : widget.id == "1"
                              ? Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: buttonbg,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Холбогдсон Карт :  1610 0000 2684 6576',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                      Text(
                        'Түүх',
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Center(
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 80,
                      //       ),
                      //       SvgPicture.asset(
                      //         'assets/svg/notfound.svg',
                      //       ),
                      //       SizedBox(
                      //         height: 15,
                      //       ),
                      //       Text(
                      //         '${widget.title}',
                      //         style: TextStyle(
                      //           color: white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         'Түүх алга байна',
                      //         style: TextStyle(
                      //           color: greytext,
                      //           fontSize: 13,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Column(
                        children: ["1", "2", "3", "4"]
                            .map(
                              (e) => Column(
                                children: [
                                  // HistoryCard(),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Divider(
                                      color: white.withOpacity(0.1),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
