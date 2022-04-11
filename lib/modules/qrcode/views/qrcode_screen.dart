import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/qrcode/controllers/get_qrcode_controller.dart';

// ignore: must_be_immutable
class QRCodeScreen extends StatelessWidget {
  QRCodeScreen({Key? key}) : super(key: key);

  final GetQrCodeController _qrCodeController = Get.put(GetQrCodeController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showInstruction(context));

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
                  Obx(() {
                    if (_qrCodeController.isLoading.value) {
                      return Center(
                        child: SpinKitFadingFour(
                          color: Colors.blue.shade900,
                          size: 50.0,
                        ),
                      );
                    } else {
                      return QrImage(
                        data: _qrCodeController.qrCodeString.value,
                        gapless: false,
                      );
                    }
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay_outlined,
                        size: 20.0.sp,
                      ),
                      Text(
                        "Tự động cập nhật sau 30 giây",
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      child: Text(
                        "Làm mới".toUpperCase(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        // onSurface: Colors.transparent,
                        // shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size.fromHeight(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                      onPressed: () {
                        _qrCodeController.getQrCode();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }

  void showInstruction(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                child: Text(
                  "Hướng dẫn sử dụng",
                  style:
                      TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                ),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Đưa mã QR của bạn lại gần thiết bị bCheckin với khoảng cách tối ưu từ 15 đến 20cm. ",
                        style: TextStyle(
                            fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/qr-code-instruction.gif',
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                    ))
              ],
            ));
  }
}
