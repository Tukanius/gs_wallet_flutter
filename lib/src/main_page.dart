// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/action_button/action_button.dart';
import 'package:green_score/components/trade_bottom_sheet/trade_bottom_sheet.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/collect_score_page/score_page.dart';
import 'package:green_score/src/home_page/home_page.dart';
import 'package:green_score/src/notification_page/notification_page.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/qr_code_page/qr_code_page.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/src/trade_page/trade_page.dart';
import 'package:green_score/src/wallet_page/wallet_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const routeName = "MainPage";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  logOut() async {
    await Provider.of<UserProvider>(context, listen: false).logout();
    await Navigator.of(context).pushNamed(SplashScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: transparent,
          elevation: 0,
          centerTitle: false,
          title: Container(
            margin: EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              },
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
              ),
            ),
          ),
          actions: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset('assets/svg/notnumber.svg'),
                ),
                Center(
                  child: ActionButton(
                    svgAssetPath: "assets/svg/notification.svg",
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(NotificationPage.routeName);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            ActionButton(
              svgAssetPath: "assets/svg/qr.svg",
              onClick: () {
                Navigator.of(context).pushNamed(QrCodePage.routeName);
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        extendBody: true,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomePage(),
            ScorePage(),
            WalletPage(),
            TradePage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: bottomnavcolor,
          ),
          alignment: Alignment.topCenter,
          child: TabBar(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            indicator: BoxDecoration(),
            dividerColor: transparent,
            controller: tabController,
            tabs: <Widget>[
              Tab(
                icon: SvgPicture.asset(
                  "assets/svg/home.svg",
                  height: 30,
                  width: 30,
                  color: currentIndex == 0 ? greentext : white,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  "assets/svg/leaf.svg",
                  height: 30,
                  width: 30,
                  color: currentIndex == 1 ? greentext : white,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  "assets/svg/wallet.svg",
                  height: 30,
                  width: 30,
                  color: currentIndex == 2 ? greentext : white,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  "assets/svg/transfer.svg",
                  height: 30,
                  width: 30,
                  color: currentIndex == 3 ? greentext : white,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: currentIndex == 3
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          trade(context, "1");
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/sell_button.svg'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Зарах',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          trade(context, "2");
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: greentext,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/buy_button.svg'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Авах',
                                style: TextStyle(color: white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
