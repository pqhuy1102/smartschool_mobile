import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_first_time_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/providers/change_password_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ChangePasswordFirstTimeController extends GetxController {
  final isNewPasswordHidden = true.obs;
  final isReNewPasswordHidden = true.obs;
  final isLoading = false.obs;

  late final ChangePasswordProvider _changePasswordProvider;
  late final AuthenticationManager _authenticationManager;
  late final LoginController _loginController;

  TextEditingController? newPasswordEditingController;
  TextEditingController? reNewPasswordEditingController;

  @override
  void onInit() {
    super.onInit();
    _changePasswordProvider = Get.put(ChangePasswordProvider());
    _authenticationManager = Get.find();
    _loginController = Get.find();

    newPasswordEditingController = TextEditingController();
    reNewPasswordEditingController = TextEditingController();
  }

  Future<void> changePasswordFirstTime(
      String newPassword, String reNewPassword) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    final res = await _changePasswordProvider.changePasswordFirstTime(
        ChangePasswordFirstTimeRequestModel(
            newPassword: newPassword.trim(),
            reNewPassword: reNewPassword.trim()),
        headers);
    if (res != null) {
      Get.snackbar('Thành công', 'Đổi mật khẩu thành công!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
      _authenticationManager.saveChangePassStatus(true);
      _authenticationManager
          .saveUsernameToStorage(_loginController.username.value);
      Get.offNamed(Routes.dashboard);
    } else {
      Get.snackbar('Lỗi ', 'Đổi mật khẩu thất bại!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
      clearTextField();
    }
  }

  //toggle password visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordHidden(!isNewPasswordHidden.value);
  }

  void toggleReNewPasswordVisibility() {
    isReNewPasswordHidden(!isReNewPasswordHidden.value);
  }

  //clear textfield
  void clearTextField() {
    newPasswordEditingController!.clear();
    reNewPasswordEditingController!.clear();
  }
}
