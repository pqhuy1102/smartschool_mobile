import 'package:get/get.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/authentication/model/login_request_model.dart';

class LoginProvider extends GetConnect {
  final String loginUrl = '${Constant.apiDomain}/login';

  Future<dynamic> login(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    if (!response.status.connectionError) {
      return response;
    } else {
      return null;
    }
  }
}
