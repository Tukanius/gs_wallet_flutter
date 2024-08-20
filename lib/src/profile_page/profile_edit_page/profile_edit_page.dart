import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/profile_page/profile_edit_page/camera_page.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  XFile? file;
  String? imageName;
  User result = User();
  ListenController listenController = ListenController();

  onsubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false)
            .editProfile(save, user.id!);

        // Navigator.of(context).pushNamed(MainPage.routeName);

        if (file != null) {
          setState(() {
            image = File(file!.path);
            loading = true;
          });
          result = await UserApi().upload(file!.path);
          print('=====RES=====');
          print(result);
          print('=====RES=====');

          await UserApi().avatar(
            User(avatar: result.url.toString()),
          );
          await Provider.of<UserProvider>(context, listen: false).me(true);
          setState(() {
            loading = false;
          });
        }
        if (isTake == true) {
          setState(() {
            image = File(listenController.value!);
          });
          result = await UserApi().upload(listenController.value!);
          await UserApi().avatar(
            User(avatar: result.url.toString()),
          );
          await Provider.of<UserProvider>(context, listen: false).me(true);
          setState(() {});
          result = await UserApi().upload(listenController.value!);
          await UserApi().avatar(
            User(avatar: result.url.toString()),
          );
          await Provider.of<UserProvider>(context, listen: false).me(true);
          setState(() {});
        }
        Navigator.of(context).pushNamed(ProfilePage.routeName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: white,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
              left: 10,
              right: 10,
            ),
            content: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Мэдээлэл амжилттай засагдлаа.',
                  style: TextStyle(
                    color: black,
                  ),
                ),
              ],
            ),
          ),
        );
        // Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  getImage(ImageSource imageSource) async {
    file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    if (file != null) {
      setState(() {
        image = File(file!.path);
      });
    }
  }

  Future showOptions() async {
    FocusScope.of(context).unfocus();
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

  bool isTake = false;
  @override
  void initState() {
    listenController.addListener(() async {
      listenController.value != null
          ? setState(() {
              isTake = true;
              image = File(listenController.value!);
            })
          : setState(() {
              isTake = false;
            });
      print('=====istake=======');
      print(isTake);
      print('=====istake=======');

      // result = await UserApi().upload(listenController.value!);
      // await UserApi().avatar(
      //   User(avatar: result.url.toString()),
      // );
      // await Provider.of<UserProvider>(context, listen: false).me(true);
      // setState(() {});
      // result = await UserApi().upload(listenController.value!);
      // await UserApi().avatar(
      //   User(avatar: result.url.toString()),
      // );
      // await Provider.of<UserProvider>(context, listen: false).me(true);
      // setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                    Navigator.of(context).pop();
                  },
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
                        GestureDetector(
                          onTap: () {
                            showOptions();
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: white.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: user.avatar != null && image == null
                                      ? Image.network(
                                          '${user.avatar}',
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : image != null
                                          ? Image.file(
                                              image!,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            )
                                          : SvgPicture.asset(
                                              'assets/svg/avatar.svg',
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: white.withOpacity(0.6),
                                  ),
                                  height: 45,
                                  width: 45,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/svg/camera.svg',
                                      height: 30,
                                      width: 30,
                                      // ignore: deprecated_member_use
                                      color: black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  FormBuilder(
                    key: fbkey,
                    child: Column(
                      children: [
                        FormTextField(
                          labelText: 'Овог',
                          initialValue: user.lastName,
                          color: buttonbg,
                          name: "firstName",
                          hintText: 'Овог',
                          colortext: white,
                          hintTextColor: white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          initialValue: user.firstName,
                          labelText: 'Нэр',
                          color: buttonbg,
                          hintText: 'Нэр',
                          name: "lastName",
                          colortext: white,
                          hintTextColor: white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          readOnly: user.danVerified == true ? true : false,
                          labelText: 'Регистрийн дугаар',
                          initialValue: user.registerNo,
                          color: buttonbg,
                          hintText: 'Регистрийн дугаар',
                          name: "registerNo",
                          colortext: white,
                          hintTextColor: white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          labelText: 'Утас',
                          initialValue: user.phone,
                          color: buttonbg,
                          hintText: 'Утас',
                          name: "phone",
                          colortext: white,
                          hintTextColor: white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          labelText: 'И-мэйл',
                          initialValue: user.email,
                          color: buttonbg,
                          hintText: 'И-мэйл',
                          name: "email",
                          colortext: white,
                          hintTextColor: white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        FormTextField(
                          initialValue: user.address,
                          labelText: 'Хаяг',
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
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
