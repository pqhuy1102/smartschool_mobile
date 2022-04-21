import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/checkinToday/providers/get_inday_attendance_provider.dart';

class GetIndayAttendanceController extends GetxController
    with StateMixin<List<dynamic>> {
  // ignore: prefer_typing_uninitialized_variables

  final isLoading = false.obs;

  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    GetIndayAttendanceProvider().getIndayAttendance(headers).then((res) {
      change(res, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error("Không có dữ liệu!"));
      Get.snackbar('Lỗi ', 'Lấy dữ liệu thất bại!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }
}
