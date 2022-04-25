import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/notification/models/update_notification_token_request_model.dart';
import 'package:smartschool_mobile/modules/notification/providers/notification_provider.dart';

class NotificationsController extends GetxController {
  late FirebaseMessaging messaging;
  var token = "".obs;
  late final NotificationProvider _notificationProvider;
  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _notificationProvider = Get.put(NotificationProvider());
    _authenticationManager = Get.find();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      token.value = value!;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {});

    updateNotificationToken(token.value);
  }

  Future<void> updateNotificationToken(String token) async {
    String? token = _authenticationManager.getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    // ignore: unused_local_variable
    final res = await _notificationProvider.updateNotificationToken(
        UpdateNotificationTokenRequestModel(notificationToken: token), headers);
  }
}
