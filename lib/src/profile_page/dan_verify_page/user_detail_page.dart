import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  static const routeName = "UserDetailPage";
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
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
              leading: CustomBackButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                'Минии мэдээлэл',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
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
                Text(
                  'Миний мэдээлэл',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: buttonbg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Овог',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          '${user.firstName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Нэр',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          '${user.lastName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Регистр',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          '${user.registerNo}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Утасны дугаар',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          '${user.phone}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'И-мэйл',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          '${user.email}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Хаяг',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        Text(
                          user.address ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Дан баталгаажуулалт',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        user.danVerified == true
                            ? Text(
                                'Амжилттай',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: greentext,
                                ),
                              )
                            : Text(
                                'Хүлээгдэж буй',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: red,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
