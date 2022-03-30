import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/profile/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Đăng xuất',
                        titleStyle: TextStyle(fontSize: 18.0.sp),
                        middleText: 'Bạn có muốn đăng xuất không?',
                        middleTextStyle: TextStyle(fontSize: 14.0.sp),
                        backgroundColor: Colors.white,
                        radius: 10.0,
                        confirm: ElevatedButton(
                            onPressed: (() {
                              _loginController.logout();
                            }),
                            child: Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  fontSize: 14.0.sp, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0.sp),
                              ),
                            )),
                        cancel: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0.sp),
                                  side:
                                      BorderSide(color: Colors.blue.shade900)),
                            ),
                            onPressed: (() {
                              Get.back();
                            }),
                            child: Text(
                              'Hủy bỏ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.blue.shade900),
                            )),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 18));
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.blue.shade900,
                  iconSize: 24.0.sp,
                )
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue.shade900,
                  size: 24.0.sp,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text(
                'Cá nhân',
                style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Obx(() {
              if (_profileController.isLoading.value) {
                return Center(
                  child: SpinKitFadingFour(
                    color: Colors.blue.shade900,
                    size: 50.0,
                  ),
                );
              } else {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SafeArea(
                      child: Form(
                          child: ListView(
                    children: [
                      imageProfile(),
                      const SizedBox(
                        height: 25,
                      ),
                      nameTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      studentIdTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      genderTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      emailTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      phoneNumberTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'cập nhật thông tin'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            primary: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0.sp),
                            ),
                          ))
                    ],
                  ))),
                );
              }
            })));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          Obx(() => SizedBox(
              height: 24.0.h,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: (_profileController.selectedImagePath.value ==
                        '')
                    ? const AssetImage('assets/images/default-avatar.png')
                    : FileImage(
                            File(_profileController.selectedImagePath.value))
                        as ImageProvider,
              ))),
          Positioned(
            bottom: 15.0,
            right: 16.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (builder) => bottomSheet());
              },
              child: Icon(
                Icons.camera_alt,
                size: 24.0.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 16.0.h,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Chọn ảnh đại diện",
            style: TextStyle(
              fontSize: 14.0.sp,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.camera,
                  ),
                  onPressed: () {
                    _profileController.getImage(ImageSource.camera);
                  },
                  label: Text(
                    "Chụp ảnh",
                    style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      side: BorderSide.none,
                      padding: const EdgeInsets.all(10)),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    _profileController.getImage(ImageSource.gallery);
                  },
                  label: Text(
                    "Thư viện",
                    style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      side: BorderSide.none,
                      padding: const EdgeInsets.all(10)),
                ),
              ])
        ],
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      initialValue: _profileController.userData.data != null
          ? _profileController.userData.data?.firstName
          : '',
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue.shade900,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue.shade900,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue.shade900,
          ),
          labelText: "Họ tên",
          labelStyle: TextStyle(color: Colors.blue.shade900)),
    );
  }

  Widget studentIdTextField() {
    return TextFormField(
      initialValue: _profileController.userData.data?.id.toString(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person_search_outlined,
          color: Colors.blue.shade900,
        ),
        labelText: "Mã sinh viên",
        labelStyle: TextStyle(color: Colors.blue.shade900),
      ),
    );
  }

  Widget genderTextField() {
    return TextFormField(
      initialValue: 'Nam',
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person_pin,
          color: Colors.blue.shade900,
        ),
        labelText: "Giới tính",
        labelStyle: TextStyle(color: Colors.blue.shade900),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      initialValue: _profileController.userData.data?.email,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.blue.shade900,
        ),
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.blue.shade900),
      ),
    );
  }

  Widget phoneNumberTextField() {
    return TextFormField(
      initialValue: '0123456789',
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue.shade900,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.phone_iphone,
          color: Colors.blue.shade900,
        ),
        labelText: "Số điện thoại",
        labelStyle: TextStyle(color: Colors.blue.shade900),
      ),
    );
  }
}
