import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/setttings/widgets/setting_item.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
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
          'Cài đặt',
          style: TextStyle(
              fontSize: 26.0.sp,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          decoration: const BoxDecoration(color: Colors.white70),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                InkWell(
                  child: const SettingItem(
                      title: "Thông tin cá nhân", icon: Icons.person),
                  onTap: () {
                    Get.toNamed(Routes.dashboard + Routes.profile);
                  },
                ),
                const SettingItem(
                  title: "Về chúng tôi",
                  icon: Icons.people_alt,
                ),
                const SettingItem(
                  title: "Ngôn ngữ",
                  icon: Icons.translate,
                ),
                const SettingItem(
                  title: "Đổi mật khẩu",
                  icon: Icons.lock,
                ),
                InkWell(
                  child: const SettingItem(
                    title: "Đăng xuất",
                    icon: Icons.logout,
                  ),
                  onTap: () {
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
                )
              ],
            ),
          )),
    ));
  }
}
