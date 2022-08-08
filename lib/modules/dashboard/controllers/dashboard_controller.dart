import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';
import 'package:smartschool_mobile/modules/checkinToday/providers/get_inday_attendance_provider.dart';
import 'package:smartschool_mobile/modules/notification/models/update_notification_token_request_model.dart';
import 'package:smartschool_mobile/modules/notification/providers/notification_provider.dart';

class DashBoardController extends GetxController {
  var fcmToken = "".obs;
  var hasInternet = false.obs;
  var indayAttendanceList = [].obs;

  final isLoading = false.obs;
  late final NotificationProvider _notificationProvider;
  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    _notificationProvider = Get.put(NotificationProvider());
    getIndayAttendance();
  }

  Future<void> updateNotificationToken(String fcmToken) async {
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    // ignore: unused_local_variable
    await _notificationProvider.updateNotificationToken(
        UpdateNotificationTokenRequestModel(notificationToken: fcmToken),
        headers);
  }

  Future<void> testNotification() async {
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await _notificationProvider.testNotification(headers);
  }

  Future<void> getIndayAttendance() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    isLoading(true);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    var res =
        await GetIndayAttendanceProvider().getIndayAttendance(headers, today);
    if (res != null && res != 'unauthorized') {
      isLoading(false);
      indayAttendanceList.value = res;
    } else if (res == 'unauthorized') {
      Get.dialog(
        AlertDialog(
          title: Text('Cảnh báo!',
              style: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red)),
          content: Text(
              'Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại!',
              style: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w600)),
          actions: [
            TextButton(
                child: Text("Đăng nhập lại",
                    style: TextStyle(
                        fontSize: 13.0.sp, color: Colors.blue.shade900)),
                onPressed: () {
                  _authenticationManager.logOut();
                  Get.offAll(() => const OnBoard());
                }),
          ],
        ),
      );

      isLoading(false);
    } else {
      isLoading(false);
    }
  }
}
