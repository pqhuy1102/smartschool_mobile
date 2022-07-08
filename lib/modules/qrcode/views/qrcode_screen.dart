import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';
import 'package:smartschool_mobile/modules/qrcode/controllers/get_qrcode_controller.dart';

// ignore: must_be_immutable
class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GetQrCodeController _qrCodeController = Get.put(GetQrCodeController());
  final GetIndayAttendanceController _getIndayAttendanceController =
      Get.put(GetIndayAttendanceController());

  @override
  Widget build(BuildContext context) {
    if (_qrCodeController.isNeverDisplayAgain.isFalse) {
      Future.delayed(Duration.zero, () => showInstruction(context));
    }

    return WillPopScope(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue.shade900,
                  size: 18.0.sp,
                ),
                onPressed: () {
                  Get.back();
                  _getIndayAttendanceController.getIndayAttendance();
                },
              ),
              title: Text(
                'Mã QR',
                style: TextStyle(
                    fontSize: 17.0.sp,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Obx(() {
              if (_qrCodeController.hasInternet.isFalse) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/lost_internet.jpg',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        if (_qrCodeController.isLoading.value) {
                          return Center(
                            child: SpinKitFadingFour(
                              color: Colors.blue.shade900,
                              size: 50.0,
                            ),
                          );
                        } else {
                          return Text(
                              'Không có kết nối, vui lòng thử lại!',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.grey.shade700,
                              ));
                        }
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: Text(
                          "Tải lại",
                          style: TextStyle(
                              fontSize: 13.0.sp, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade900,
                          // onSurface: Colors.transparent,
                          // shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 50),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0.sp),
                          ),
                        ),
                        onPressed: () {
                          _qrCodeController.getQrCode();
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: SafeArea(
                      child: SingleChildScrollView(
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
                                return GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.all(12.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.blue.shade900,
                                                  width: 8),
                                              left: BorderSide(
                                                  color: Colors.blue.shade900,
                                                  width: 8),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                                right: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                                right: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                                left: BorderSide(
                                                    color: Colors.blue.shade900,
                                                    width: 8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: QrImage(
                                            size: _qrCodeController
                                                .qrCodeSize.value,
                                            embeddedImage: const AssetImage(
                                                'assets/images/logo_mini.png'),
                                            embeddedImageStyle:
                                                QrEmbeddedImageStyle(
                                                    size: const Size(60, 60)),
                                            foregroundColor:
                                                Colors.blue.shade900,
                                            data: _qrCodeController
                                                .qrCodeString.value,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => _qrCodeController.handleQrSize(),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.replay_outlined,
                                    size: 20.0.sp,
                                  ),
                                  Text(
                                    "Tự động cập nhật sau ${_qrCodeController.countDown.value} giây",
                                    style: TextStyle(
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              );
                            }),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 10),
                              child: ElevatedButton(
                                child: Text(
                                  "Làm mới".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade900,
                                  // onSurface: Colors.transparent,
                                  // shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 40),

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
                    ));
              }
            })),
        onWillPop: () async {
          _getIndayAttendanceController.getIndayAttendance();
          return true;
        });
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
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Center(
                        child: Text(
                          "Đưa mã QR của bạn lại gần thiết bị bCheckin với khoảng cách tối ưu từ 15 đến 20cm. ",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Image.asset(
                        'assets/images/qr-code-instruction.gif',
                      ),
                      Obx((() => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 30.0,
                                    width: 30.0,
                                    child: Checkbox(
                                        activeColor: Colors.blue.shade900,
                                        value: _qrCodeController
                                            .isNeverDisplayAgain.value,
                                        onChanged: (value) {
                                          _qrCodeController.isNeverDisplayAgain
                                              .value = value!;
                                          _qrCodeController.box.write(
                                              'isNeverDisplayAgain', value);
                                        })),
                                const SizedBox(width: 4.0),
                                Text(
                                  "Không hiển thị lại!",
                                  style: TextStyle(fontSize: 12.0.sp),
                                )
                              ])))
                    ]),
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade900),
                    ))
              ],
            ));
  }
}
