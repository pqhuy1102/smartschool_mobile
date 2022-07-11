import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/resetPassword/models/reset_password_request_model.dart';
import 'package:smartschool_mobile/modules/resetPassword/providers/reset_password_provider.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;

  late final ResetPasswordProvider _resetPasswordProvider;

  TextEditingController? emailEditingController;

  var hasInternet = false.obs;

  @override
  void onInit() {
    super.onInit();

    getInternetStatus();

    emailEditingController = TextEditingController();

    _resetPasswordProvider = Get.put(ResetPasswordProvider());

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
    });
  }

  Future<void> resetPassword(String email) async {
    isLoading(true);
    final res = await _resetPasswordProvider
        .resetPassword(ResetPasswordRequestModel(email: email.trim()));

    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', "Bạn chưa kết nối internet!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (!res.hasError) {
        Get.back();
        Get.snackbar('Thành công',
            "Mật khẩu mới đã được gửi tới email của bạn!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoading(false);
        clearTextField();
      } else {
        Get.snackbar('Lỗi ', "Reset mật khẩu thất bại!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        isLoading(false);
        clearTextField();
      }
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  //clear textfield
  void clearTextField() {
    emailEditingController!.clear();
  }
}
