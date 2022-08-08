import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';

class LoginProvider extends GetConnect {
  final String loginUrl = '${Constant.apiDomain}/login';
  final String loginGoogleUrl = '${Constant.apiDomain}/login-google';

  Future<dynamic> login(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    return response;
  }

  Future<dynamic> loginWithGoogle(token) async {
    final response = await post(loginGoogleUrl, 'model', headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == HttpStatus.ok) {
      return response;
    } else {
      return null;
    }
  }
}
