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
  }

  void login(String? token) async {
    isLogged.value = true;

    //Token is cached
    await saveToken(token);
  }

  void changePasswordFirstTimeStatus(bool isActivate) async {
    await saveChangePassStatus(isActivate);
  }

  void saveUsernameToStorage(String name) async {
    await saveUsername(name);
  }

  void changeUsername() {
    final name = getUsername();
    if (name != null) {
      username.value = name;
    }
  }

  void changePassStatus() {
    final status = getChangePassStatus();
    if (status != null) {
      isActivated.value = status;
    }
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
