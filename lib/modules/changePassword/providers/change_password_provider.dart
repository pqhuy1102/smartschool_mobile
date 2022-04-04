import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_response_model.dart';

class ChangePasswordProvider extends GetConnect {
  final String changePasswordUrl =
      'http://13.228.244.196:6002/mobile/change-password';

  Future<ChangePasswordResponseModel?> changePassword(
      ChangePasswordRequestModel model, headers) async {
    final response =
        await put(changePasswordUrl, model.toJson(), headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return ChangePasswordResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
