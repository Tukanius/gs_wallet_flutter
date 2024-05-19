import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class ConfirmQrCodePageArguments {
  Deposit data;
  ConfirmQrCodePageArguments({
    required this.data,
  });
}

class ConfirmQrCodePage extends StatefulWidget {
  final Deposit data;
  static const routeName = "ConfirmQrCodePage";
  const ConfirmQrCodePage({super.key, required this.data});

  @override
  State<ConfirmQrCodePage> createState() => _ConfirmQrCodePageState();
}

class _ConfirmQrCodePageState extends State<ConfirmQrCodePage> {
  bool isLoading = false;
  Deposit deposit = Deposit();

  onDepositConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      deposit = await WalletApi().depositConfirm(widget.data.id!);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed(MainPage.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Төлбөр төлөх',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нийт төлөх дүн: ${widget.data.amount}',
                style: TextStyle(color: white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Төлбөрийн хэрэгсэл: ${widget.data.method}',
                style: TextStyle(color: white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Тайлбар: ${widget.data.description}',
                style: TextStyle(color: white),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onClick: () {
                        Navigator.of(context).pushNamed(MainPage.routeName);
                      },
                      buttonColor: white,
                      height: 40,
                      isLoading: isLoading,
                      labelText: "Болих",
                      textColor: black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomButton(
                      onClick: () {
                        onDepositConfirm();
                      },
                      buttonColor: greentext,
                      height: 40,
                      isLoading: isLoading,
                      labelText: "Төлөх",
                      textColor: white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
