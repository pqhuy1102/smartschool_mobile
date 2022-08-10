import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/profile/models/profile_response_model.dart';
import 'package:smartschool_mobile/modules/profile/providers/profile_provider.dart';

class ProfileController extends GetxController {
  //manage image picker
  var selectedImagePath = ''.obs;

  var hasInternet = false.obs;

  var isLoading = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var _userData;
  var userName = RxString('');

  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();

    getInternetStatus();

    getProfileUser();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
      if (hasInternet.isTrue) {
        getProfileUser();
      }
    });
  }

  ProfileResponseModel? get userData => _userData;

  Future<void> getProfileUser() async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    bool isGoogleLogin = _authenticationManager.getLoginType();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
      "Login-Type": isGoogleLogin ? 'google-type' : '',
    };
    var res = await ProfileProvider().getProfileUser(headers);
    if (res != null) {
      _userData = res;
      userName.value = res.studentName;
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }
}
