import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';

class LoginProvider extends GetConnect {
  final String loginUrl = 'http://13.228.244.196:6002/login';

  //login
  Future<dynamic> login(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());
    if (!response.status.connectionError) {
      return response;
    } else {
      return null;
    }
  }
}
