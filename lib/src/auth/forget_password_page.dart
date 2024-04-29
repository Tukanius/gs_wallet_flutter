import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:green_score/widget/ui/qwerty.dart';
import 'package:provider/provider.dart';
import 'package:green_score/src/auth/opt_page.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = "ForgetPassword";
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false)
            .forgetPass(save);
        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(OtpPage.routeName,
            arguments: OtpPageArguments(isForget: true, email: save.email!));
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
            'Нууц үг сэргээх',
            style: TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FormBuilder(
              key: fbkey,
              child: Column(
                children: [
                  FormTextField(
                    color: buttonbg,
                    name: "username",
                    hintText: 'Утасны дугаар',
                    colortext: white,
                    hintTextColor: white.withOpacity(0.5),
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
              buttonColor: greentext,
              height: 40,
              isLoading: isLoading,
              labelText: 'Үргэлжлүүлэх',
              textColor: white,
            ),
          ],
        ),
      ),
    );
  }
}