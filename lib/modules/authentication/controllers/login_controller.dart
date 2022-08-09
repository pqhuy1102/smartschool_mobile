import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';
import 'package:smartschool_mobile/modules/authentication/providers/login_provider.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';

class LoginController extends GetxController {
  late final LoginProvider _loginProvider;
  late final AuthenticationManager _authenticationManager;

  var isLoading = false.obs;
  var isLoginGoogleLoading = false.obs;

  var username = "".obs;

  var isActivated = false.obs;

  var hasInternet = false.obs;

  final _googleSignIn = GoogleSignIn(
    clientId:
        "82945894712-rp99rrdgq5ab7ja7cup95g37dfia6isf.apps.googleusercontent.com",
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  var googleAccount = Rx<GoogleSignInAccount?>(null);

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

  Future<void> googleLogin() async {
    isLoginGoogleLoading(true);
    try {
      googleAccount.value = await _googleSignIn.signIn();
      final googleAuth = await googleAccount.value!.authentication;

      final res = await _loginProvider.loginWithGoogle(googleAuth.accessToken);
      if (res != null) {
        username.value = res.body['username'];
        isActivated(true);
        _authenticationManager.changePasswordFirstTimeStatus(true);
        _authenticationManager.login(googleAuth.accessToken, username.value);

        Get.snackbar('Thành công', 'Đăng nhập thành công!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoginGoogleLoading(false);
      } else {
        Get.snackbar('Thất bại', 'Đăng nhập thất bại!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        isLoginGoogleLoading(false);
      }
    } catch (e) {
      Get.snackbar(
          'Thất bại',
          e.toString() ==
                  'PlatformException(network_error, com.google.android.gms.common.api.ApiException: 7: , null, null)'
              ? "Bạn chưa kết nối internet!"
              : "Đăng nhập thất bại!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoginGoogleLoading(false);
    }
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
        isLoading(false);
      }
    }
  }

  //logout
  void logout() async {
    _authenticationManager.logOut();
    await _googleSignIn.signOut();

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
