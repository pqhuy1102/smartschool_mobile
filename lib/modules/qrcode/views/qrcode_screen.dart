import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue.shade900,
            size: 24.0.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Mã QR',
          style: TextStyle(
              fontSize: 26.sp,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SafeArea(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: Random().nextInt(1900).toString(),
                    version: 3,
                    gapless: false,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      child: Text(
                        "Làm mới",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        // onSurface: Colors.transparent,
                        // shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 110, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
