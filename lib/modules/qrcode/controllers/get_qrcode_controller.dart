import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/qrcode/providers/get_qrcode_provider.dart';

class GetQrCodeController extends GetxController {
  final isLoading = false.obs;

  final qrCodeString = ''.obs;

  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    getQrCode();
  }

  Future<void> getQrCode() async {
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
}
