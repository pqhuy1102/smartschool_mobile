import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> settingsTitle = [
      'Đổi mật khẩu',
      'Về chúng tôi',
      'Đăng xuất'
    ];
    final List<IconData> settingsIcon = [
      Icons.lock_outline,
      Icons.people_alt,
      Icons.logout
    ];

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
              fontSize: 26.sp,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white,
          child: SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: settingsTitle.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(settingsIcon[index]),
                      title: Text(settingsTitle[index]),
                    ));
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.grey),
            ),
          )),
    ));
  }
}
