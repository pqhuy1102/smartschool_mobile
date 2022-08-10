import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  Future<bool> saveChangePassStatus(bool isActivate) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ISACTIVATE.toString(), isActivate);
    return true;
  }

  bool? getChangePassStatus() {
    final box = GetStorage();
    return box.read(CacheManagerKey.ISACTIVATE.toString());
  }

  Future<void> removeChangePassStatus() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.ISACTIVATE.toString());
  }

  Future<bool> saveLoginType(bool isGoogleLogin) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.LOGINTYPE.toString(), isGoogleLogin);
    return true;
  }

  bool getLoginType() {
    final box = GetStorage();
    return box.read(CacheManagerKey.LOGINTYPE.toString());
  }

  Future<void> removeLoginType() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.LOGINTYPE.toString());
  }

  Future<bool> saveUsername(String? name) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.USERNAME.toString(), name);
    return true;
  }

  String? getUsername() {
    final box = GetStorage();
    return box.read(CacheManagerKey.USERNAME.toString());
  }

  Future<void> removeUsername() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.USERNAME.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { TOKEN, ISACTIVATE, USERNAME, LOGINTYPE }
