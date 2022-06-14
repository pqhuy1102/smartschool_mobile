import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/setttings/widgets/setting_item.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final List locale = [
    {'name': 'English(US)', 'locale': const Locale('en', 'US')},
    {'name': 'Tiếng Việt', 'locale': const Locale('vi', 'VN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  handleChangeLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text(
              'choose your language'.tr,
              style: TextStyle(fontSize: 16.0.sp),
            ),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(
                          locale[index]['name'],
                          style: TextStyle(fontSize: 14.0.sp),
                        ),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

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
            size: 18.0.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'settings'.tr,
          style: TextStyle(
              fontSize: 17.0.sp,
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
                  child: SettingItem(
                      title: "personal information".tr, icon: Icons.person),
                  onTap: () {
                    Get.toNamed(Routes.dashboard + Routes.profile);
                  },
                ),
                InkWell(
                  child: SettingItem(
                    title: "change password".tr,
                    icon: Icons.lock,
                  ),
                  onTap: () {
                    Get.toNamed(Routes.dashboard +
                        Routes.settings +
                        Routes.changePassword);
                  },
                ),
                InkWell(
                  child: SettingItem(
                    title: "logout".tr,
                    icon: Icons.logout,
                  ),
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Đăng xuất',
                        titleStyle: TextStyle(
                            fontSize: 16.0.sp, fontWeight: FontWeight.w600),
                        middleText: 'Bạn có muốn đăng xuất không?',
                        middleTextStyle: TextStyle(
                            fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                        backgroundColor: Colors.white,
                        radius: 10.0,
                        confirm: ElevatedButton(
                            onPressed: (() {
                              _loginController.logout();
                            }),
                            child: Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
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
                                  side: BorderSide(
                                      color: Colors.blue.shade900, width: 1.5)),
                            ),
                            onPressed: (() {
                              Get.back();
                            }),
                            child: Text(
                              'Hủy bỏ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600,
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
