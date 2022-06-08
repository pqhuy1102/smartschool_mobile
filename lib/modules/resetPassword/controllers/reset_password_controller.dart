import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/resetPassword/models/reset_password_request_model.dart';
import 'package:smartschool_mobile/modules/resetPassword/providers/reset_password_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;

  late final ResetPasswordProvider _resetPasswordProvider;

  TextEditingController? emailEditingController;

  @override
  void onInit() {
    super.onInit();

    emailEditingController = TextEditingController();

    _resetPasswordProvider = Get.put(ResetPasswordProvider());
  }

  Future<void> resetPassword(String email) async {
    isLoading(true);
    final res = await _resetPasswordProvider
        .resetPassword(ResetPasswordRequestModel(email: email.trim()));
    if (!res.hasError) {
      Get.snackbar('Thành công', res.body['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
      Get.toNamed(Routes.login);
    } else {
      Get.snackbar('Lỗi ', "Có lỗi xảy ra!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
    }
  }

  //clear textfield
  void clearTextField() {
    emailEditingController!.clear();
  }
}
