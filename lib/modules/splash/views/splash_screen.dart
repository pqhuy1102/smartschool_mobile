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
    _authmanager.changePassStatus();
    _authmanager.changeUsername();
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
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 25.0.h,
            ),
            Text(
              "Chào mừng đến",
              style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 22.0.sp,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Student Connect",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: SpinKitFadingFour(
                color: Colors.blue.shade900,
                size: 35.0.sp,
              ),
            )
          ],
        ),
      )),
    ));
  }

  //error view
  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }
}
