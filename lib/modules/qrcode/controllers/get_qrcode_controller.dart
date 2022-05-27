import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';

import 'package:smartschool_mobile/modules/qrcode/providers/get_qrcode_provider.dart';

class GetQrCodeController extends GetxController {
  final isLoading = false.obs;

  final qrCodeString = ''.obs;

  late final AuthenticationManager _authenticationManager;

  final countDown = 30.obs;

  Timer? timer;

  final isNeverDisplayAgain = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();

    //get qr code first time
    getQrCode();

    //renew get qrcode after 30s
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      decreaseCounter();
      if (countDown.value == 0) {
        countDown.value = 30;
        getQrCode();
      }
    });

    readIsNeverAskAgain();
  }

  decreaseCounter() {
    countDown.value -= 1;
  }

  Future<void> getQrCode() async {
    countDown.value = 30;
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await GetQrCodeProvider().getQrCode(headers);
    if (res != null) {
      qrCodeString.value = res.qrString;
      isLoading(false);
    } else {
      Get.snackbar('Error ', 'Không tìm thấy dữ liệu!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    }
  }

  void readIsNeverAskAgain() {
    if (box.read('isNeverDisplayAgain') != null) {
      isNeverDisplayAgain.value = box.read('isNeverDisplayAgain');
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    timer!.cancel();
  }
}
