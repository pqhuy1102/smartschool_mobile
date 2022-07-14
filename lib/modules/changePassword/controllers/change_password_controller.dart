import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/providers/change_password_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  final isOldPasswordHidden = true.obs;
  final isNewPasswordHidden = true.obs;
  final isReNewPasswordHidden = true.obs;
  final isLoading = false.obs;
  var hasInternet = false.obs;

  late final ChangePasswordProvider _changePasswordProvider;
  late final AuthenticationManager _authenticationManager;

  TextEditingController? oldPasswordEditingController;
  TextEditingController? newPasswordEditingController;
  TextEditingController? reNewPasswordEditingController;

  @override
  void onInit() {
    super.onInit();

    getInternetStatus();

    _changePasswordProvider = Get.put(ChangePasswordProvider());
    _authenticationManager = Get.find();

    oldPasswordEditingController = TextEditingController();
    newPasswordEditingController = TextEditingController();
    reNewPasswordEditingController = TextEditingController();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
    });
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': 'Bearer $token',
    };
    final res = await _changePasswordProvider.changePassword(
        ChangePasswordRequestModel(
            oldPassword: oldPassword.trim(),
            newPassword: newPassword.trim(),
            reNewPassword: confirmPassword.trim()),
        headers);

    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', 'Bạn chưa kết nối internet!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (res == true) {
        Get.snackbar('Thành công', 'Đổi mật khẩu thành công!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoading(false);
        clearTextField();
        Get.toNamed(Routes.dashboard);
      } else {
        Get.snackbar('Lỗi ', res.body["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        isLoading(false);
      }
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

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  //clear textfield
  void clearTextField() {
    oldPasswordEditingController!.clear();
    newPasswordEditingController!.clear();
    reNewPasswordEditingController!.clear();
  }
}
