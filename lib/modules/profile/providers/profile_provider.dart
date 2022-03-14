import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/profile/models/profile_response_model.dart';
//import 'package:smartschool_mobile/modules/profile/controllers/profile_controller.dart';

class ProfileProvider extends GetConnect {
  final String getProfileUrl = 'https://reqres.in/api/users/2';
  //final ProfileController _profileController = Get.put(ProfileController());

  Future<ProfileResponseModel?> getProfileUser() async {
    final response = await get(getProfileUrl);
    if (response.statusCode == HttpStatus.ok) {
      return profileResponseModelFromJson(response.bodyString!);
    } else {
      return null;
    }
  }
}
