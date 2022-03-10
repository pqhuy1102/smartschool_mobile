import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';
import 'routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  //initialize for data persistency
  await GetStorage.init();

  //wrap app with device preview
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => const MyApp(),
  // ));
  const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: Routes.splash,
        getPages: AppPages.routes,
        title: 'Smart School App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans'),
      );
    });
  }
}
