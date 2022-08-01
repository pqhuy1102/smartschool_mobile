import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

  var hasInternet = false.obs;

  TextEditingController? emailEditingController;
  TextEditingController? passwordEditingController;

  //visibility password
  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loginProvider = Get.put(LoginProvider());
    _authenticationManager = Get.find();

    getInternetStatus();

    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
    });
  }

  //login
  Future<void> login(String email, String password) async {
    isLoading(true);
    final res = await _loginProvider.login(
        LoginRequestModel(email: email.trim(), password: password.trim()));
    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', "Bạn chưa kết nối internet!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (!res.hasError) {
        _authenticationManager.login(res.body['token'], res.body['username']);
        username.value = res.body['username'];

        isActivated.value = res.body['is_activate'];
        if (isActivated.value) {
          _authenticationManager
              .changePasswordFirstTimeStatus(res.body['is_activate']);
        }
        Get.snackbar('Thành công', 'Đăng nhập thành công!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoading(false);
      } else {
        if (res != null) {
          final error = res.body['message'] == "Wrong password"
              ? "Sai mật khẩu"
              : res.body['message'];
          Get.snackbar('Lỗi ', error,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      }
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

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }
}
