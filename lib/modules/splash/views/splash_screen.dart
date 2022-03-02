import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/dashboard/views/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Get.off(() => const DashBoardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/background_image.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 150, bottom: 30),
                height: h * 0.16,
                width: w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://phenikaamaas.com/wp-content/themes/phenikaa-theme-dev/images/logo-black.png'),
                ))),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                "Welcome to",
                style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "bCheckin HCMUS",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: SpinKitFadingFour(
                color: Colors.blue.shade900,
                size: 50.0,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
