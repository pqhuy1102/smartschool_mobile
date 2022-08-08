import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';

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
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await GetQrCodeProvider().getQrCode(headers);
    if (res != null) {
      qrCodeString.value = res.qrString;
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
