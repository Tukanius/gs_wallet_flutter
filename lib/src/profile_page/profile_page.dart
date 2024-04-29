import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/profile_page/profile_edit_page.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/qwerty.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "ProfilePage";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  logOut() async {
    await Provider.of<UserProvider>(context, listen: false).logout();
    await Navigator.of(context).pushNamed(SplashScreen.routeName);
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
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'USERNAME',
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  buttonColor: greentext,
                  height: 40,
                  isLoading: false,
                  labelText: 'Мэдээлэл засах',
                  onClick: () {
                    Navigator.of(context).pushNamed(ProfileEdit.routeName);
                  },
                  textColor: white,
                ),
                Divider(
                  color: buttonbg,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  buttonColor: greentext,
                  height: 40,
                  isLoading: false,
                  labelText: 'Тохиргоо',
                  onClick: () {
                    comingSoon(context);
                  },
                  textColor: white,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  buttonColor: greentext,
                  height: 40,
                  isLoading: false,
                  labelText: 'Тусламж',
                  onClick: () {
                    comingSoon(context);
                  },
                  textColor: white,
                ),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonColor: greentext,
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
