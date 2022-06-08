import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';
import 'package:smartschool_mobile/modules/authentication/providers/login_provider.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';

class LoginController extends GetxController {
  late final LoginProvider _loginProvider;
  late final AuthenticationManager _authenticationManager;

  var isLoading = false.obs;

  var username = "".obs;

  var isActivated = false.obs;

  TextEditingController? emailEditingController;
  TextEditingController? passwordEditingController;

  //visibility password
  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loginProvider = Get.put(LoginProvider());
    _authenticationManager = Get.find();

    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  //login
  Future<void> login(String email, String password) async {
    isLoading(true);
    final res = await _loginProvider.login(
        LoginRequestModel(email: email.trim(), password: password.trim()));
    if (res != null && !res.hasError) {
      _authenticationManager.login(res.body['token']);
      _authenticationManager
          .changePasswordFirstTimeStatus(res.body['is_activate']);
      username.value = res.body['username'];
      _authenticationManager.saveUsernameToStorage(res.body['username']);
      isActivated.value = res.body['is_activate'];

      Get.snackbar('Thành công', 'Đăng nhập thành công!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      isLoading(false);
    } else if (res != null && res.hasError) {
      final error = res.body['message'] == "Wrong password"
          ? "Sai mật khẩu"
          : res.body['message'];
      Get.snackbar('Lỗi ', error,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      Get.snackbar('Lỗi ', "Bạn chưa kết nối internet!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    }
  }

  //logout
  void logout() {
    _authenticationManager.logOut();
    Get.offAll(() => const OnBoard());

    Get.snackbar('Thành công', 'Đăng xuất thành công!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  //toggle password
  void togglePasswordVisibility() {
    isPasswordHidden(!isPasswordHidden.value);
  }
}
