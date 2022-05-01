// ignore_for_file: prefer_equal_for_default_values
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());

  //initialize settings
  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();

    //Simulate other services for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        //check connection state before move to OnBoard screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnBoard();
          }
        }
      },
    );
  }

  //waiting view
  Scaffold waitingView() {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/background_login.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 100, bottom: 20),
                child: Image.asset(
                  'assets/images/logo-hcmus-new.png',
                  fit: BoxFit.contain,
                  height: 200.0,
                  width: 180.0,
                )),
            Text(
              "Welcome to",
              style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 26.0.sp,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "bCheckin HCMUS",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 26.0.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: SpinKitFadingFour(
                color: Colors.blue.shade900,
                size: 40.0.sp,
              ),
            )
          ],
        ),
      ),
    ));
  }

  //error view
  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }
}
