import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/wallet_page/card_detail_page/bottom_sheets/bank_sheet.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:lottie/lottie.dart';

TextEditingController textEditingController = TextEditingController();
bool isLoading = false;
int value = 0;

showSuccess(context) async {
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
                        color: dark, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Данс амжилттай цэнэглэгдлээ.',
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
                          "Буцах",
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

income(BuildContext context, String id) {
  Deposit deposit = Deposit();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        onBankApp() async {
          setState(() {
            isLoading = true;
          });
          try {
            value = int.parse(textEditingController.text);
            deposit.amount = value;
            deposit.paymentMethod = "TRANSFER";
            deposit = await WalletApi().depositAccount(id, deposit);
            bank(context, deposit);
            setState(() {
              textEditingController.clear();
              isLoading = true;
            });
          } catch (e) {
            print(e.toString());
          }
          setState(() {
            isLoading = true;
          });
        }

        qpay() async {
          setState(() {
            isLoading = true;
          });
          try {
            value = int.parse(textEditingController.text);
            deposit.amount = value;
            deposit.paymentMethod = "QPAY";
            deposit = await WalletApi().depositAccount(id, deposit);
            deposit = await WalletApi().depositConfirm(deposit.id!);
            setState(() {
              textEditingController.clear();
              isLoading = false;
            });
            Navigator.of(context).pushNamed(MainPage.routeName);
            showSuccess(context);
          } catch (e) {
            print(e.toString());
            setState(() {
              isLoading = false;
            });
          }
        }

        socialpay() async {
          setState(() {
            isLoading = true;
          });
          try {
            value = int.parse(textEditingController.text);
            deposit.amount = value;
            deposit.paymentMethod = "SOCIALPAY";
            deposit = await WalletApi().depositAccount(id, deposit);
            deposit = await WalletApi().depositConfirm(deposit.id!);
            setState(() {
              textEditingController.clear();
              isLoading = false;
            });
            Navigator.of(context).pushNamed(MainPage.routeName);
            showSuccess(context);
          } catch (e) {
            print(e.toString());
            setState(() {
              textEditingController.clear();

              isLoading = false;
            });
          }
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: nfc,
                      borderRadius: BorderRadius.circular(50),
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
                      Text(
                        'Хэтэвч цэнэглэх',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                  FormTextField(
                    inputType: TextInputType.number,
                    controller: textEditingController,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/tugrug.svg'),
                      ],
                    ),
                    hintText: "Цэнэглэлт хийх дүн",
                    colortext: black,
                    color: black.withOpacity(0.04),
                    name: "search",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         height: 52,
                      //         width: 52,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(16),
                      //           color: black.withOpacity(0.04),
                      //         ),
                      //         child: Center(
                      //           child: SvgPicture.asset(
                      //             'assets/svg/wallet_black.svg',
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Text(
                      //         'Карт',
                      //         style: TextStyle(
                      //           color: black,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onBankApp();
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: black.withOpacity(0.04),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    width: 24,
                                    height: 24,
                                    'assets/svg/bank.svg',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Дансаар',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                qpay();
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/qpay.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Qpay',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                socialpay();
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/socialpay.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Social Pay',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
