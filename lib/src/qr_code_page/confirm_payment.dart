import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/utils/utils.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';

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
      showSuccess(context);
      Navigator.of(context).pushNamed(MainPage.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

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
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Төлөлт амжилттай.',
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
                            "хаах",
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 60,
                automaticallyImplyLeading: false,
                pinned: false,
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: transparent,
                leading: CustomBackButton(
                  onClick: () {
                    Navigator.of(context).pushNamed(MainPage.routeName);
                  },
                ),
                centerTitle: true,
                title: Text(
                  'Төлбөр төлөх',
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ];
          },
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: greentext,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: buttonbg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Нийт төлөх дүн:',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${Utils().formatCurrency(widget.data.amount.toString())}₮',
                                    // '${widget.data.amount}₮',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Төлбөрийн хэрэгсэл:',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${widget.data.method}',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Тайлбар:',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${widget.data.description}',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomButton(
                            buttonColor: greentext,
                            height: 40,
                            isLoading: isLoading,
                            labelText: 'Төлбөр төлөх',
                            onClick: () {
                              onDepositConfirm();
                            },
                            textColor: white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            buttonColor: buttonbg,
                            height: 40,
                            isLoading: false,
                            labelText: 'Болих',
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(MainPage.routeName);
                            },
                            textColor: white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
/* 
Column(
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
*/