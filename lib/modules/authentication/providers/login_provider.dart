import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_respone_model.dart';

class LoginProvider extends GetConnect {
  final String loginUrl = 'https://reqres.in/api/login';

  //login
  Future<LoginResponseModel?> login(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
