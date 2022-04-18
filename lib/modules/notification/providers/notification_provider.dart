import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/notification/models/update_notification_token_request_model.dart';

class NotificationProvider extends GetConnect {
  final String updateNotificationTokenUrl =
      "http://13.228.244.196:6002/user/update-notification-token";

  //update notification token
  Future<String?> updateNotificationToken(
      UpdateNotificationTokenRequestModel model, headers) async {
    final response = await post(updateNotificationTokenUrl, model.toJson(),
        headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return response.bodyString;
    } else {
      return null;
    }
  }
}
