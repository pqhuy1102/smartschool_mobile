import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  final isActivated = false.obs;
  final username = "".obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
    removeChangePassStatus();
    removeUsername();
    removeLoginType();
  }

  void login(String? token, String? name, bool isGoogleLogin) async {
    isLogged.value = true;

    //Token is cached
    await saveToken(token);
    await saveLoginType(isGoogleLogin);
    await saveUsername(name);
  }

  void changePasswordFirstTimeStatus(bool isActivate) async {
    await saveChangePassStatus(isActivate);
  }

  void changePassStatus() {
    final status = getChangePassStatus();
    if (status != null) {
      isActivated.value = status;
    }
  }

  void checkLoginStatus() {
    final token = getToken();
    final name = getUsername();
    if (name != null) {
      username.value = name;
    }
    // final res = await LoginProvider().loginWithGoogle(token);
    // if(res != null){

    // }
    if (token != null) {
      isLogged.value = true;
    }
  }
}
