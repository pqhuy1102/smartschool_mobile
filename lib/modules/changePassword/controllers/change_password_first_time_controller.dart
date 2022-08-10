import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_first_time_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/providers/change_password_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ChangePasswordFirstTimeController extends GetxController {
  final isNewPasswordHidden = true.obs;
  final isReNewPasswordHidden = true.obs;
  final isLoading = false.obs;
  var hasInternet = false.obs;

  late final ChangePasswordProvider _changePasswordProvider;
  late final AuthenticationManager _authenticationManager;
  // ignore: unused_field
  late final LoginController _loginController;

  TextEditingController? newPasswordEditingController;
  TextEditingController? reNewPasswordEditingController;

  @override
  void onInit() {
    super.onInit();
    _changePasswordProvider = Get.put(ChangePasswordProvider());
    _authenticationManager = Get.find();
    _loginController = Get.find();

    getInternetStatus();

    newPasswordEditingController = TextEditingController();
    reNewPasswordEditingController = TextEditingController();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
    });
  }

  Future<void> changePasswordFirstTime(
      String newPassword, String reNewPassword) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    bool isGoogleLogin = _authenticationManager.getLoginType();
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': 'Bearer $token',
      "Login-Type": isGoogleLogin ? 'google-type' : '',
    };

    final res = await _changePasswordProvider.changePasswordFirstTime(
        ChangePasswordFirstTimeRequestModel(
            newPassword: newPassword.trim(),
            reNewPassword: reNewPassword.trim()),
        headers);

    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', 'Bạn chưa kết nối internet!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (res.body['is_activate'] == true) {
        Get.snackbar('Thành công', res.body['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoading(false);
        clearTextField();
        _authenticationManager.saveChangePassStatus(true);

        Get.offNamed(Routes.dashboard);
      } else {
        Get.snackbar('Lỗi ', res.body['message'],
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
