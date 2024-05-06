import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/auth/forget_page.dart';
import 'package:green_score/src/auth/register_page.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:provider/provider.dart';
import 'package:green_score/models/user.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).login(save);
        await Provider.of<UserProvider>(context, listen: false).me(true);
        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(MainPage.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: buttonbg,
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/splash.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                FormBuilder(
                  key: fbkey,
                  child: Column(
                    children: [
                      FormTextField(
                        labelText: "Утасны дугаар",
                        color: buttonbg,
                        name: "username",
                        hintText: 'Утасны дугаар',
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        labelText: "Нууц үг",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible == false
                              ? Icon(Icons.visibility, color: white)
                              : Icon(Icons.visibility_off, color: white),
                        ),
                        inputType: TextInputType.visiblePassword,
                        color: buttonbg,
                        hintText: 'Нууц үг',
                        name: "password",
                        colortext: white,
                        obscureText: isVisible,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  onClick: () {
                    onSubmit();
                  },
                  buttonColor: greentext,
                  height: 40,
                  isLoading: isLoading,
                  labelText: 'Нэвтрэх',
                  textColor: white,
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ForgetPassword.routeName);
                  },
                  child: Text(
                    "Нууц үг сэргээх",
                    style: TextStyle(color: greentext),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Бүртгэл үүсгэх бол энд дарна уу !",
                      style: TextStyle(
                        color: white,
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterPage.routeName);
                      },
                      child: Text(
                        "Бүртгүүлэх",
                        style: TextStyle(color: greentext),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
