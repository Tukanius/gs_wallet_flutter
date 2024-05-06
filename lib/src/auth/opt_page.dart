import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/auth/password_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpPageArguments {
  String username;
  String method;
  OtpPageArguments({
    required this.username,
    required this.method,
  });
}

class OtpPage extends StatefulWidget {
  final String username;
  final String method;
  static const routeName = "OtpPage";
  const OtpPage({
    super.key,
    required this.username,
    required this.method,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with AfterLayoutMixin {
  int _counter = 180;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  bool isLoading = true;
  late Timer _timer;
  User user = User();
  ListenController listenController = ListenController();

  @override
  void initState() {
    listenController.addListener(() async {
      await Provider.of<UserProvider>(context, listen: false)
          .getOtp(widget.method, widget.username.toLowerCase().trim());
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    _startTimer();
    user = await Provider.of<UserProvider>(context, listen: false)
        .getOtp(widget.method, widget.username.toLowerCase().trim());
    setState(() {
      isLoading = false;
    });
  }

  checkOpt(value) async {
    user.otpCode = value;
    user.otpMethod = widget.method;
    await Provider.of<UserProvider>(context, listen: false).otpVerify(user);
    await Navigator.of(context).pushNamed(PassWordPage.routeName,
        arguments: PassWordPageArguments(method: widget.method));
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    } else {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    }
  }

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String minutes = m.toString().padLeft(2, '0');
    String seconds = s.toString().padLeft(2, '0');
    String result = "$minutes:$seconds";
    return result;
  }

  final defaultPinTheme = PinTheme(
    width: 80,
    height: 80,
    textStyle:
        TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: buttonbg,
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: transparent,
        elevation: 0,
        centerTitle: true,
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
        title: Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            'Баталгаажуулалт',
            style: TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: greentext,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        '${user.message}',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (isGetCode == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Дахин код авах ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: white,
                              ),
                            ),
                            Text(
                              '${intToTimeLeft(_counter)} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: white,
                              ),
                            ),
                            Text(
                              'секунд',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: white,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isSubmit = true;
                                });
                                _startTimer();
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getOtp("REGISTER",
                                        widget.username.toLowerCase().trim());
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: white,
                                  ),
                                  Text(
                                    "Код дахин авах",
                                    style: TextStyle(
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Баталгаажуулалт',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (value) => checkOpt(value),
                        // validator: (value) {
                        //   return value == "${user.otpCode}"
                        //       ? null
                        //       : "Буруу байна";
                        // },
                        length: 6,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        defaultPinTheme: defaultPinTheme,
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // CustomButton(
                      //   onClick: () {},
                      //   buttonColor: buttongreen,
                      //   labelText: 'Баталгаажуулалт',
                      //   textColor: white,
                      //   isLoading: false,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
