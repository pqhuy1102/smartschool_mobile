import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'Đăng xuất',
                    titleStyle: TextStyle(
                      fontSize:
                          textScale > 1.4 ? 15.0.sp / textScale * 1.4 : 15.0.sp,
                    ),
                    middleText: 'Bạn có muốn đăng xuất không?',
                    middleTextStyle: TextStyle(
                        fontSize: textScale > 1.4
                            ? 14.0.sp / textScale * 1.4
                            : 14.0.sp),
                    backgroundColor: Colors.white,
                    radius: 10.0,
                    confirm: ElevatedButton(
                        onPressed: (() {
                          _loginController.logout();
                        }),
                        child: Text(
                          'Đăng xuất',
                          style: TextStyle(
                              fontSize: textScale > 1.4
                                  ? 14.0.sp / textScale * 1.4
                                  : 14.0.sp,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade600,
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
                              side: BorderSide(color: Colors.blue.shade900)),
                        ),
                        onPressed: (() {
                          Get.back();
                        }),
                        child: Text(
                          'Hủy bỏ',
                          style: TextStyle(
                              fontSize: textScale > 1.4
                                  ? 14.0.sp / textScale * 1.4
                                  : 14.0.sp,
                              color: Colors.blue.shade900),
                        )),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 18));
              },
              icon: const Icon(Icons.logout),
              color: Colors.blue.shade900,
              iconSize: 18.0.sp,
            )
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue.shade900,
              size: 18.0.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Cá nhân',
            style: TextStyle(
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() {
          if (_profileController.isLoading.value == true) {
            return Center(
              child: SpinKitFadingFour(
                color: Colors.blue.shade900,
                size: 50.0,
              ),
            );
          } else {
            if (_profileController.hasInternet.isTrue) {
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: nameTextField(),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: studentIdTextField(),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: studentClassTextField(),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: genderTextField()),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: emailTextField()),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: phoneNumberTextField()),
                    const SizedBox(
                      height: 22,
                    ),
                  ],
                ))),
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/lost_internet.jpg',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (_profileController.isLoading.value) {
                        return Center(
                          child: SpinKitFadingFour(
                            color: Colors.blue.shade900,
                            size: 50.0,
                          ),
                        );
                      } else {
                        return Text('Không có kết nối, vui lòng thử lại!',
                            style: TextStyle(
                              fontSize: textScale > 1.4
                                  ? 14.0.sp / textScale * 1.4
                                  : 14.0.sp,
                              color: Colors.grey.shade700,
                            ));
                      }
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text(
                        "Tải lại",
                        style: TextStyle(
                            fontSize: textScale > 1.4
                                ? 13.0.sp / textScale * 1.4
                                : 13.0.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        // onSurface: Colors.transparent,
                        // shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 50),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                      onPressed: () {
                        _profileController.getProfileUser();
                      },
                    ),
                  ],
                ),
              );
            }
          }
        }));
  }

  Widget imageProfile() {
    return const Center(
      child: FittedBox(
          fit: BoxFit.fill,
          child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/avatar.png'))),
    );
  }

  Widget nameTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return TextFormField(
        enabled: false,
        initialValue: _profileController.userData?.studentName,
        style: TextStyle(
          fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
          fontWeight: FontWeight.w500,
        ),
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
            size: 20.0.sp,
          ),
          labelText: "Họ tên",
          labelStyle: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
        ));
  }

  Widget studentClassTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return TextFormField(
      enabled: false,
      initialValue: _profileController.userData?.studentClass,
      style: TextStyle(
        fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
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
          Icons.class_,
          color: Colors.blue.shade900,
          size: 20.0.sp,
        ),
        labelText: "Lớp học",
        labelStyle: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
      ),
    );
  }

  Widget studentIdTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return TextFormField(
      enabled: false,
      initialValue: _profileController.userData?.studentId,
      style: TextStyle(
        fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
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
          Icons.badge,
          color: Colors.blue.shade900,
          size: 20.0.sp,
        ),
        labelText: "Mã sinh viên",
        labelStyle: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
      ),
    );
  }

  Widget genderTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return TextFormField(
      enabled: false,
      initialValue: _profileController.userData?.gender,
      style: TextStyle(
        fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
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
          Icons.people,
          color: Colors.blue.shade900,
          size: 20.0.sp,
        ),
        labelText: "Giới tính",
        labelStyle: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
      ),
    );
  }

  Widget emailTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Row(
      children: [
        Expanded(
            child: TextFormField(
          enabled: false,
          initialValue: _profileController.userData?.email,
          style: TextStyle(
            fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
            fontWeight: FontWeight.w500,
          ),
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
              size: 20.0.sp,
            ),
            labelText: "Email",
            labelStyle:
                TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
          ),
        ))
      ],
    );
  }

  Widget phoneNumberTextField() {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return TextFormField(
      enabled: false,
      initialValue: _profileController.userData?.phoneNumber,
      style: TextStyle(
        fontSize: textScale > 1.0 ? 11.0.sp / textScale : 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
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
          Icons.phone_sharp,
          color: Colors.blue.shade900,
          size: 20.0.sp,
        ),
        labelText: "Số điện thoại",
        labelStyle: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
      ),
    );
  }
}
