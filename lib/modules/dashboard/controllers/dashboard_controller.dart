import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/notification/models/update_notification_token_request_model.dart';
import 'package:smartschool_mobile/modules/notification/providers/notification_provider.dart';

class DashBoardController extends GetxController {
  var fcmToken = "".obs;
  late final NotificationProvider _notificationProvider;
  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    _notificationProvider = Get.put(NotificationProvider());
  }

  Future<void> updateNotificationToken(String fcmToken) async {
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    // ignore: unused_local_variable
    await _notificationProvider.updateNotificationToken(
        UpdateNotificationTokenRequestModel(notificationToken: fcmToken),
        headers);
  }

  Future<void> testNotification() async {
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await _notificationProvider.testNotification(headers);
  }
}
