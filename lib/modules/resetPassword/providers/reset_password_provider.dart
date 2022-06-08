import 'package:get/get.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/resetPassword/models/reset_password_request_model.dart';

class ResetPasswordProvider extends GetConnect {
  final String resetPasswordUrl = '${Constant.apiDomain}/reset-password';

  //login
  Future<dynamic> resetPassword(ResetPasswordRequestModel model) async {
    final response = await post(resetPasswordUrl, model.toJson());
    return response;
  }
}
