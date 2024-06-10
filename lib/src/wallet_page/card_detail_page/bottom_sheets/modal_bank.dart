import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';

class ModalApp extends StatefulWidget {
  const ModalApp({super.key});

  @override
  State<ModalApp> createState() => _ModalAppState();
}

class _ModalAppState extends State<ModalApp> {
  bool isLoading = true;

  void bank(String amount, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
            color: white,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: nfc,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Center(
                        child: Text(
                          'Данс $amount',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: SvgPicture.asset('assets/svg/close.svg'),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '   Дансны дугаар:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: '900 004 7728'))
                            .then(
                          (value) {
                            return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: greytext,
                                content: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Амжилттай хуулсан'),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/copy.svg'),
                        ],
                      ),
                    ),
                    hintText: "5050232303",
                    colortext: black,
                    color: black.withOpacity(0.04),
                    name: "search",
                    hintTextColor: black,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '   Дансны нэр:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("object");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/copy.svg'),
                        ],
                      ),
                    ),
                    hintText: "Good Score",
                    colortext: black,
                    color: black.withOpacity(0.04),
                    hintTextColor: black,
                    name: "search",
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '   Гүйлгээний утга:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    readOnly: true,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/copy.svg'),
                      ],
                    ),
                    hintText: "Цэнэглэлт - 99555555",
                    hintTextColor: black,
                    colortext: black,
                    color: black.withOpacity(0.04),
                    name: "search",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonColor: greentext,
                    height: 40,
                    isLoading: isLoading,
                    labelText: 'Төлбөр төлөх',
                    onClick: () {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    textColor: white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonColor: greentext,
                    height: 40,
                    isLoading: isLoading,
                    labelText: 'Төлбөр шалгах',
                    onClick: () {
                      setState(() {
                        print('helo');
                        isLoading = false;
                      });
                    },
                    textColor: white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('hello');
          bank("1234", "1");
        },
        child: SvgPicture.asset('assets/svg/bank.svg'),
      ),
    );
  }
}
