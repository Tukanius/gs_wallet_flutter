import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';

void bank(BuildContext context, bool isLoading, Result bankList) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: Text(
                        'Данс',
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
                if (bankList.rows?.length != 0)
                  DropdownButtonFormField(
                    onChanged: (value) {
                      print(value.toString());
                      // setState(() {
                      //   accountId = "${value?.id}";
                      //   print(accountId.toString());
                      //   isBankError = false;
                      // });
                    },
                    dropdownColor: white,
                    itemHeight: 70,
                    menuMaxHeight: 400,
                    elevation: 2,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      hintText: 'Данс сонгоно уу',
                      hintStyle: TextStyle(
                          color: Theme.of(context).disabledColor, fontSize: 14),
                      filled: true,
                      fillColor: black.withOpacity(0.04),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: bankList.rows
                        ?.map(
                          (item) => DropdownMenuItem(
                            enabled: true,
                            value: item,
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/avatar.jpg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  // "${item.bankAccount} / ${item.bankName}",
                                  "${item.bankAccount} / ${item.bankName}",
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                else
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: buttonbg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Холбосон данс байхгүй байна",
                          style: TextStyle(color: black, fontSize: 12),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Данс холбох",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
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
              ],
            ),
          ),
        ),
      );
    },
  );
}
