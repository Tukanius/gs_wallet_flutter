import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:green_score/widget/ui/qwerty.dart';
import 'package:provider/provider.dart';

class PassWordPageArguments {
  bool? isForgot;
  PassWordPageArguments({
    this.isForgot,
  });
}

class PassWordPage extends StatefulWidget {
  final bool? isForgot;
  static const routeName = "PassWordPage";
  const PassWordPage({super.key, this.isForgot});

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isVisible1 = true;
  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false)
            .setPassword(save);
        // await Provider.of<UserProvider>(context, listen: false).me(false);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamed(MainPage.routeName);
      } catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
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
              'Нууц үг',
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Цаашид нэврэх нууц үгээ оруулна уу !',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
              SizedBox(
                height: 40,
              ),
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
                      // validators: FormBuilderValidators.compose([
                      //   FormBuilderValidators.required(
                      //       errorText: 'Нууц үгээ оруулна уу.')
                      // ]),
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
                      // validators: FormBuilderValidators.compose([
                      //   FormBuilderValidators.required(
                      //       errorText: "Нууц үгээ давтан оруулна уу"),
                      //   (value) {
                      //     if (fbkey.currentState?.fields['password']?.value !=
                      //         value) {
                      //       return 'Оруулсан нууц үгтэй таарахгүй байна';
                      //     }
                      //     return null;
                      //   }
                      // ]),
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
    );
  }
}
