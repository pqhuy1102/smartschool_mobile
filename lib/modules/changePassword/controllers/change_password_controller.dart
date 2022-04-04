import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/providers/change_password_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  final isChangedPassword = false.obs;
  final isOldPasswordHidden = true.obs;
  final isNewPasswordHidden = true.obs;
  final isReNewPasswordHidden = true.obs;
  final isLoading = false.obs;

  late final ChangePasswordProvider _changePasswordProvider;
  late final AuthenticationManager _authenticationManager;

  TextEditingController? oldPasswordEditingController;
  TextEditingController? newPasswordEditingController;
  TextEditingController? reNewPasswordEditingController;

  @override
  void onInit() {
    super.onInit();
    _changePasswordProvider = Get.put(ChangePasswordProvider());
    _authenticationManager = Get.find();

    oldPasswordEditingController = TextEditingController();
    newPasswordEditingController = TextEditingController();
    reNewPasswordEditingController = TextEditingController();
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final res = await _changePasswordProvider.changePassword(
        ChangePasswordRequestModel(
            oldPassword: oldPassword.trim(),
            newPassword: newPassword.trim(),
            reNewPassword: confirmPassword.trim()),
        headers);
    if (res != null) {
      Get.snackbar('Thành công', 'Đổi mật khẩu thành công!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
      Get.toNamed(Routes.dashboard);
    } else {
      Get.snackbar('Lỗi ', 'Đổi mật khẩu thất bại!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
    }
  }

  //toggle password
  void toggleOldPasswordVisibility() {
    isOldPasswordHidden(!isOldPasswordHidden.value);
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden(!isNewPasswordHidden.value);
  }

  void toggleReNewPasswordVisibility() {
    isReNewPasswordHidden(!isReNewPasswordHidden.value);
  }

  //clear textfield
  void clearTextField() {
    oldPasswordEditingController!.clear();
    newPasswordEditingController!.clear();
    reNewPasswordEditingController!.clear();
  }
}
