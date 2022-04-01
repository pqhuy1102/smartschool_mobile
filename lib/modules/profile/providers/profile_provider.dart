import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/profile/models/profile_response_model.dart';
//import 'package:smartschool_mobile/modules/profile/controllers/profile_controller.dart';

class ProfileProvider extends GetConnect {
  final String getProfileUrl = 'http://13.228.244.196:6002/user/me';

  Future<ProfileResponseModel?> getProfileUser(headers) async {
    final response = await get(getProfileUrl, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return profileResponseModelFromJson(response.bodyString!);
    } else {
      return null;
    }
  }
}
