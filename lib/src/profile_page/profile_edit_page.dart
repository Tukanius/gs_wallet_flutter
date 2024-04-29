import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/profile_page/camera_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:green_score/widget/ui/qwerty.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class ProfileEdit extends StatefulWidget {
  static const routeName = "ProfileEdit";
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool loading = false;

  String id = "";
  User user = User();
  final picker = ImagePicker();
  File? image;
  String? imageName;
  User result = User();
  ListenController listenController = ListenController();

  onsubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false)
            .editProfile(save, user.id!);
        Navigator.of(context).pop();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);

    if (file != null) {
      setState(() {
        image = File(file.path);
        isLoading = true;
      });
      result = await UserApi().upload(file.path);
      print('=====RES=====');
      print(result);
      print('=====RES=====');

      await UserApi().avatar(
        User(avatar: result.url.toString()),
      );
      await Provider.of<UserProvider>(context, listen: false).me(true);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Зургийн сангаас',
              style: TextStyle(color: black, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Зураг авах',
              style: TextStyle(color: black, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              camera();
            },
          ),
        ],
      ),
    );
  }

  camera() {
    Navigator.of(context).pushNamed(
      CameraPage.routeName,
      arguments: CameraPageArguments(listenController: listenController),
    );
  }

  @override
  void initState() {
    listenController.addListener(() async {
      result = await UserApi().upload(listenController.value!);
      await UserApi().avatar(
        User(avatar: result.url.toString()),
      );
      await Provider.of<UserProvider>(context, listen: false).me(true);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;

    return BackgroundShapes(
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
              centerTitle: true,
              title: Text(
                'Мэдээлэл засах',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: user.avatar != null && image == null
                            ? Image.network(
                                '${user.avatar}',
                                fit: BoxFit.cover,
                              )
                            : image != null
                                ? Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/avatar.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      GestureDetector(
                        onTap: showOptions,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/avatar.jpg'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'USERNAME',
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн овог',
                //   value: user.username,
                // ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн нэр',
                //   value: user.username,
                // ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн регистер',
                //   value: user.username,
                // ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн утас',
                //   value: user.username,
                // ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн и-мэйл',
                //   value: user.username,
                // ),
                // InformationCard(
                //   paddingVertical: 10,
                //   labelText: 'Хэрэглэгчийн хаяг',
                //   value: user.username,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                FormBuilder(
                  key: fbkey,
                  child: Column(
                    children: [
                      FormTextField(
                        color: buttonbg,
                        name: "firstName",
                        hintText: 'Овог',
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        color: buttonbg,
                        hintText: 'Нэр',
                        name: "lastName",
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        color: buttonbg,
                        hintText: 'Регистрийн дугаар',
                        name: "registerNo",
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        color: buttonbg,
                        hintText: 'Утас',
                        name: "phone",
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        color: buttonbg,
                        hintText: 'И-мэйл',
                        name: "email",
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        color: buttonbg,
                        hintText: 'Хаяг',
                        name: "address",
                        colortext: white,
                        hintTextColor: white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                CustomButton(
                  buttonColor: greentext,
                  height: 40,
                  isLoading: isLoading,
                  labelText: 'Хадгалах',
                  onClick: () {
                    onsubmit();
                  },
                  textColor: white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
