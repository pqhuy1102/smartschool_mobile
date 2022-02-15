import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.dashboard,
      getPages: AppPages.routes,
      title: 'Smart School App',
    );
  }
}
