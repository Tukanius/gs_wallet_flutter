import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:green_score/api/wallet_api.dart';

bank(BuildContext context, Deposit data) {
  bool isLoading = false;
  Deposit deposit = Deposit();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        onSubmit() async {
          setState(() {
            isLoading = true;
          });
          try {
            deposit = await WalletApi().depositConfirm(data.id!);
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).pushNamed(MainPage.routeName);
            print(deposit);
          } catch (e) {
            print(e.toString());
          }
          setState(() {
            isLoading = false;
          });
        }

        ;
        onCheck() {
          setState(() {
            isLoading = true;
          });
          try {} catch (e) {
            print(e.toString());
          }
          setState(() {
            isLoading = false;
          });
        }

        ;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text(
                          'Данс ${data.amount}',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/svg/close.svg'),
                      ),
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
                  data.paymentStatus == "NEW"
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: greentext,
                          ),
                          child: ElevatedButton(
                            onPressed: onSubmit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isLoading == true)
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                Text(
                                  'Төлбөр төлөх',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              shadowColor: Colors.transparent,
                              backgroundColor: greentext,
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: greentext,
                          ),
                          child: ElevatedButton(
                            onPressed: onCheck,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isLoading == true)
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                Text(
                                  'Төлбөр шалгах',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              shadowColor: Colors.transparent,
                              backgroundColor: greentext,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
