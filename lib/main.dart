import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/LocaleString.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';
import 'routes/routes.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:device_preview/device_preview.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

void main() async {
  //initialize for data persistency
  await GetStorage.init();
  //initialize for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        translations: LocaleString(),
        locale: const Locale("vi", "VN"),
        fallbackLocale: const Locale("vi", "VN"),
        initialRoute: Routes.splash,
        getPages: AppPages.routes,
        title: 'Smart School App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans'),
      );
    });
  }
}
