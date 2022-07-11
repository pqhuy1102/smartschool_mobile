import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_first_time_response_model.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_first_time_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_request_model.dart';
import 'package:smartschool_mobile/modules/changePassword/models/change_password_response_model.dart';

class ChangePasswordProvider extends GetConnect {
  final String changePasswordUrl =
      '${Constant.apiDomain}/mobile/change-password';
  final String changePasswordFirstTimeUrl =
      '${Constant.apiDomain}/user/change-password-firsttime';

  Future<dynamic> changePassword(
      ChangePasswordRequestModel model, headers) async {
    final response = await put(
      changePasswordUrl,
      model.toJson(),
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return response;
    }
  }

  Future<dynamic> changePasswordFirstTime(
      ChangePasswordFirstTimeRequestModel model, headers) async {
    final response = await post(changePasswordFirstTimeUrl, model.toJson(),
        headers: headers);
    return response;
  }
}
