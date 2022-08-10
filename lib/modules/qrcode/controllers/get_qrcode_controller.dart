import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';

import 'package:smartschool_mobile/modules/qrcode/providers/get_qrcode_provider.dart';

class GetQrCodeController extends GetxController {
  final isLoading = false.obs;

  var hasInternet = false.obs;

  final qrCodeString = ''.obs;

  late final AuthenticationManager _authenticationManager;

  final countDown = 30.obs;

  Timer? timer;

  final isNeverDisplayAgain = false.obs;

  final box = GetStorage();

  final qrCodeSize = 250.0.obs;

  @override
  void onInit() {
    super.onInit();

    _authenticationManager = Get.put(AuthenticationManager());

    getInternetStatus();

    //get qr code first time
    getQrCode();

    //renew get qrcode after 30s
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      decreaseCounter();
      if (countDown.value == 0) {
        countDown.value = 15;
        getQrCode();
      }
    });

    readIsNeverAskAgain();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
      if (hasInternet.isTrue) {
        getQrCode();
      }
    });
  }

  decreaseCounter() {
    countDown.value -= 1;
  }

  Future<void> getQrCode() async {
    countDown.value = 15;
    isLoading(true);
    String? token = _authenticationManager.getToken();
    bool isGoogleLogin = _authenticationManager.getLoginType();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
      "Login-Type": isGoogleLogin ? 'google-type' : '',
    };
    var res = await GetQrCodeProvider().getQrCode(headers);
    if (res != null && res != 'unathorized') {
      qrCodeString.value = res.qrString;
      isLoading(false);
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
        barrierDismissible: false,
      );
      qrCodeString.value = '';
      isLoading(false);
    } else {
      qrCodeString.value = '';
      isLoading(false);
    }
  }

  void readIsNeverAskAgain() {
    if (box.read('isNeverDisplayAgain') != null) {
      isNeverDisplayAgain.value = box.read('isNeverDisplayAgain');
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  void handleQrSize() {
    if (qrCodeSize.value == 250.0) {
      qrCodeSize.value = 310.0;
    } else {
      qrCodeSize.value = 250.0;
    }
  }

  void handleQrSizeTablet() {
    qrCodeSize.value = 300.0;
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
