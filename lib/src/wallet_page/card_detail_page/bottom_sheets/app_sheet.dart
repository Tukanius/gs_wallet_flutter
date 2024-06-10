// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/widget/ui/color.dart';

app(BuildContext context, String text, String id) {
  bool isLoading = false;
  Deposit deposit = Deposit();
  int value = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        qpay() async {
          setState(() {
            isLoading = true;
          });
          try {
            value = int.parse(text);
            deposit.amount = value;
            deposit.paymentMethod = "QPAY";
            deposit = await WalletApi().depositAccount(id, deposit);
            print('=======QPAY======');
            print(deposit);
            print('=======QPAY======');

            setState(() {
              isLoading = false;
            });
          } catch (e) {
            print(e.toString());
          }
          setState(() {
            isLoading = false;
          });
        }

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
                          'Апп-аар',
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
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      child: Image.asset(
                        'assets/images/qr.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Боломжтой апп-ууд",
                    style: TextStyle(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            qpay();
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/images/qpay.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/images/socialpay.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
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
