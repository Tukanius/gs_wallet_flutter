import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/custom_button/profile_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/profile_page/profile_edit_page.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "ProfilePage";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User();
  bool isLoading = true;
  logOut() async {
    await Provider.of<UserProvider>(context, listen: false).logout();
    await stopService();
    await Navigator.of(context).pushNamed(SplashScreen.routeName);
  }

  stopService() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    } else {
      service.startService();
    }
    setState(() {});
  }

  comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
          content: Text(
            'Тун удахгүй!',
            style: TextStyle(
              color: black,
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
                  style: TextStyle(color: black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  successDan(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
          content: Text(
            'Амжилттай!',
            style: TextStyle(
              color: black,
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
                  style: TextStyle(color: black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  danVerify() async {
    var res = await UserApi().danVerify();
    print(res);
    successDan(context);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushNamed(MainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
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
                'Хэрэглэгчийн хэсэг',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: user.avatar != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage('${user.avatar}'),
                                backgroundColor: greytext,
                              )
                            : SvgPicture.asset(
                                'assets/svg/avatar.svg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${user.lastName}',
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${user.firstName}',
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                ProfileButton(
                  text: 'Мэдээлэл засах',
                  svgPath: 'assets/svg/edit.svg',
                  onClick: () {
                    Navigator.of(context).pushNamed(ProfileEdit.routeName);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ProfileButton(
                  text: 'ДАН баталгаажуулалт',
                  svgPath: 'assets/svg/settings.svg',
                  onClick: () {
                    danVerify();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // ProfileButton(
                //   text: 'Тохиргоо',
                //   svgPath: 'assets/svg/settings.svg',
                //   onClick: () {
                //     comingSoon(context);
                //   },
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // ProfileButton(
                //   text: 'Тусламж',
                //   svgPath: 'assets/svg/help.svg',
                //   onClick: () {
                //     comingSoon(context);
                //   },
                // ),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonColor: red,
                  height: 40,
                  isLoading: false,
                  labelText: 'Гарах',
                  onClick: logOut,
                  textColor: white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
