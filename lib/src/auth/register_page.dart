import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/auth/opt_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'RegisterPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVisible = true;
  bool isLoading = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).register(save);
        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(
          OtpPage.routeName,
          arguments:
              OtpPageArguments(method: "REGISTER", username: save.phone!),
        );
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
            'Бүртгүүлэх',
            style: TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FormBuilder(
                key: fbkey,
                child: Column(
                  children: [
                    FormTextField(
                      labelText: "Овог",
                      color: buttonbg,
                      name: "lastName",
                      hintText: 'Овог',
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Нэр",
                      color: buttonbg,
                      hintText: 'Нэр',
                      name: "firstName",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Регистрийн дугаар",
                      color: buttonbg,
                      hintText: 'Регистрийн дугаар',
                      name: "registerNo",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Утас",
                      color: buttonbg,
                      hintText: 'Утас',
                      name: "phone",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "И-мэйл",
                      color: buttonbg,
                      hintText: 'И-мэйл',
                      name: "email",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                buttonColor: greentext,
                height: 40,
                isLoading: isLoading,
                labelText: "Бүртгүүлэх",
                onClick: () {
                  onSubmit();
                },
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
