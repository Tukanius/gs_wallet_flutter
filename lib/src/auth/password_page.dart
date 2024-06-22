import 'package:after_layout/after_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/services/notify_service.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PassWordPageArguments {
  String? method;
  PassWordPageArguments({
    this.method,
  });
}

class PassWordPage extends StatefulWidget {
  final String? method;
  static const routeName = "PassWordPage";
  const PassWordPage({super.key, this.method});

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isVisible1 = true;
  bool isLoading = false;
  String deviceToken = '';
  bool isLoadingPage = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await initFireBase();
        User save = User.fromJson(fbkey.currentState!.value);
        save.deviceToken = deviceToken;
        await Provider.of<UserProvider>(context, listen: false)
            .setPassword(save);

        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(SplashScreen.routeName);
      } catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _fireBaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _fireBaseMessage.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('ehelsee');
        NotifyService().showNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        print('${message.notification?.title}');
        print('${message.notification?.body}');
        print('duusasaa');
      }
    });
    return (deviceToken == null) ? "" : deviceToken;
  }

  initFireBase() async {
    deviceToken = await getDeviceToken();
    print('====CHECKDEVICETOKEN=====');
    print(deviceToken);
    print('====CHECKDEVICETOKEN=====');
  }

  @override
  afterFirstLayout(BuildContext context) {
    try {
      setState(() {
        isLoadingPage = true;
      });
      initFireBase();
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
      print(e.toString());
    }
  }

  showSuccess(ctx) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Амжилттай',
                      style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Нууц үг амжилттай үүслээ нэвтэрнэ үү.',
                      textAlign: TextAlign.center,
                    ),
                    ButtonBar(
                      buttonMinWidth: 100,
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            "хаах",
                            style: TextStyle(color: dark),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Lottie.asset('assets/success.json', height: 150, repeat: false),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: BackgroundShapes(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: transparent,
            elevation: 0,
            centerTitle: true,
            leading: CustomBackButton(
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
            title: Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Нууц үг',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: isLoadingPage == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: greentext,
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      FormBuilder(
                        key: fbkey,
                        child: Column(
                          children: [
                            FormTextField(
                              labelText: "Нууц үг",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible == false
                                    ? Icon(
                                        Icons.visibility,
                                        color: white,
                                      )
                                    : Icon(Icons.visibility_off, color: white),
                              ),
                              inputType: TextInputType.visiblePassword,
                              color: buttonbg,
                              colortext: white,
                              hintText: 'Нууц үг',
                              name: "password",
                              obscureText: isVisible,
                              validators: FormBuilderValidators.compose([
                                (value) {
                                  return validatePassword(
                                      value.toString(), context);
                                }
                              ]),
                            ),
                            const SizedBox(height: 20),
                            FormTextField(
                              labelText: "Нууц үг баталгаажуулах",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible1 = !isVisible1;
                                  });
                                },
                                icon: isVisible1 == false
                                    ? Icon(Icons.visibility, color: white)
                                    : Icon(Icons.visibility_off, color: white),
                              ),
                              inputType: TextInputType.visiblePassword,
                              color: buttonbg,
                              colortext: white,
                              hintText: 'Нууц үг',
                              name: "password1",
                              obscureText: isVisible1,
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: "Нууц үгээ давтан оруулна уу"),
                                (value) {
                                  if (fbkey.currentState?.fields['password']
                                          ?.value !=
                                      value) {
                                    return 'Оруулсан нууц үгтэй таарахгүй байна';
                                  }
                                  return null;
                                }
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onClick: () {
                          onSubmit();
                        },
                        height: 40,
                        buttonColor: greentext,
                        labelText: 'Хадгалах',
                        textColor: white,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

String? validatePassword(String value, context) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return 'Нууц үгээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Нууц үг багадаа 1 том үсэг 1 тэмдэгт авна';
    } else {
      return null;
    }
  }
}
