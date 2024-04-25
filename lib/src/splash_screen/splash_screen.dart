import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/provider/general_provider.dart';
import 'package:green_score/src/auth/login_page.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:after_layout/after_layout.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {
  int isOne = 2;
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      // await Provider.of<GeneralProvider>(context, listen: false).init(false);
      // await Provider.of<UserProvider>(context, listen: false).me(false);
      Navigator.of(context).pushNamed(MainPage.routeName);
    } catch (ex) {
      debugPrint(ex.toString());
      Navigator.of(context).pushNamed(MainPage.routeName);

      // Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/splash.svg',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Green ',
                  style: TextStyle(
                    color: greentext,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Score',
                  style: TextStyle(
                    color: white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
