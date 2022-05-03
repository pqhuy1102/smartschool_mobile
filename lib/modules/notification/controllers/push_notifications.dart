import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  String? token;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.

      // For testing purposes print the Firebase Messaging token
      token = await _firebaseMessaging.getToken();

      _initialized = true;
    }
  }
}