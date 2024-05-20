import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/auth/opt_page.dart';
import 'package:green_score/utils/is_device_size.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:provider/provider.dart';
import 'package:green_score/widget/register-number/letter.dart';
import 'package:green_score/widget/register-number/letters.dart';

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
  TextEditingController regnumController = TextEditingController();
  List<String> letters = [
    CYRILLIC_ALPHABETS_LIST[0],
    CYRILLIC_ALPHABETS_LIST[0]
  ];
  String registerNo = "";
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        save.registerNo =
            '${letters.join()}${fbkey.currentState?.value["registerNo"]}';
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

  void onChangeLetter(String item, index) {
    Navigator.pop(context);

    setState(() {
      letters[index] = item;
    });
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      labelText: "Овог",
                      color: buttonbg,
                      name: "lastName",
                      hintText: 'Овог',
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                      validators: FormBuilderValidators.compose([
                        (value) {
                          return isValidCryllic(value.toString(), context);
                        }
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Нэр",
                      color: buttonbg,
                      hintText: 'Нэр',
                      name: "firstName",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                      validators: FormBuilderValidators.compose([
                        (value) {
                          return isValidCryllic(value.toString(), context);
                        }
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "Утасны дугаар",
                      color: buttonbg,
                      hintText: 'Утасны дугаар',
                      name: "phone",
                      colortext: white,
                      inputType: TextInputType.phone,
                      hintTextColor: white.withOpacity(0.5),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Утасны дугаараа оруулна уу.'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      labelText: "И-мэйл",
                      color: buttonbg,
                      hintText: 'И-мэйл',
                      name: "email",
                      colortext: white,
                      hintTextColor: white.withOpacity(0.5),
                      validators: FormBuilderValidators.compose([
                        (value) {
                          return validateEmail(value.toString(), context);
                        }
                      ]),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      margin: EdgeInsets.only(bottom: 8, left: 6),
                      child: Text(
                        "Регистрийн дугаар",
                        style: TextStyle(
                          fontSize: 14,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    FormBuilderField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: "registerNo",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Заавал бөглөнө үү'),
                        (dynamic value) => value.toString() != ""
                            ? (validateStructure(
                                    letters.join(), value.toString())
                                ? null
                                : "Регистрийн дугаараа оруулна уу!")
                            : null,
                      ]),
                      builder: (FormFieldState<dynamic> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            errorText: field.errorText,
                            fillColor: buttonbg,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                RegisterLetters(
                                  width: DeviceSize.width(3, context),
                                  height: DeviceSize.height(90, context),
                                  oneTitle: "Регистер дугаар сонгох",
                                  hideOnPressed: false,
                                  title: letters[0],
                                  textColor: white,
                                  length: CYRILLIC_ALPHABETS_LIST.length,
                                  itemBuilder: (ctx, i) => RegisterLetter(
                                    text: CYRILLIC_ALPHABETS_LIST[i],
                                    onPressed: () {
                                      onChangeLetter(
                                          CYRILLIC_ALPHABETS_LIST[i], 0);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                RegisterLetters(
                                  width: DeviceSize.width(3, context),
                                  height: DeviceSize.height(90, context),
                                  title: letters[1],
                                  oneTitle: "Регистер дугаар сонгох",
                                  hideOnPressed: false,
                                  textColor: white,
                                  length: CYRILLIC_ALPHABETS_LIST.length,
                                  itemBuilder: (ctx, i) => RegisterLetter(
                                    text: CYRILLIC_ALPHABETS_LIST[i],
                                    onPressed: () {
                                      onChangeLetter(
                                          CYRILLIC_ALPHABETS_LIST[i], 1);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: FormTextField(
                                    colortext: white,
                                    color: transparent,
                                    onChanged: (value) {
                                      setState(() {
                                        registerNo = value!;
                                      });
                                      // ignore: invalid_use_of_protected_member
                                      field.setValue(value);
                                    },
                                    // fi: true,
                                    // fillColor: white,
                                    controller: regnumController,
                                    name: 'registerNumber',
                                    hintText: 'Регистрийн дугаар',
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // FormTextField(
                    //   labelText: "Регистрийн дугаар",
                    //   color: buttonbg,
                    //   hintText: 'Регистрийн дугаар',
                    //   name: "registerNo",
                    //   colortext: white,
                    //   hintTextColor: white.withOpacity(0.5),
                    // ),
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

String? validateRegisterNo(String value, context) {
  RegExp regex = RegExp(r'[а-яА-ЯёЁөӨүҮ]{2}\d{8}$');
  if (value.isEmpty) {
    return 'Регистрийн дугаараа оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Зөвхөн криллээр бичнэ үү';
    } else {
      return null;
    }
  }
}

String? isValidCryllic(String name, BuildContext context) {
  String pattern = r'(^[а-яА-ЯӨөҮүЁёӨө -]+$)';
  RegExp isValidName = RegExp(pattern);
  if (name.isEmpty) {
    return "Заавар оруулна";
  } else {
    if (!isValidName.hasMatch(name)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}

String? validatePhone(String value, context) {
  RegExp regex = RegExp(r'[(9|8]{1}[0-9]{7}$');
  if (value.isEmpty) {
    return 'Утасны дугаараа оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Утасны дугаараа шалгана уу';
    } else {
      return null;
    }
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'И-Мэйлээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мэйл буруу байна';
    } else {
      return null;
    }
  }
}

bool validateStructure(String value, String number) {
  if (number.length < 8) return false;
  if (isNumeric(number)) {
    return true;
  }
  return true;
}

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }

  return !int.parse(s).isNaN;
}
