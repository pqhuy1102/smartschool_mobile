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

  Future<void> login(String email, String password) async {
    isLoading(true);
    final res = await _loginProvider
        .login(LoginRequestModel(email: email, password: password));
    if (res != null) {
      _authenticationManager.login(res.token);
      Get.snackbar('Success', 'Đăng nhập thành công!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      isLoading(false);
    } else {
      Get.snackbar('Error ', 'Đăng nhập thất bại!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    }
  }

  void logout() {
    _authenticationManager.logOut();
    Get.offAll(const OnBoard());

    Get.snackbar('Success', 'Đăng xuất thành công!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  void togglePasswordVisibility() {
    isPasswordHidden(!isPasswordHidden.value);
  }
}
