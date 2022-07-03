import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';
import 'package:smartschool_mobile/modules/checkinToday/widgets/checkin_today_item.dart';
import 'package:smartschool_mobile/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:smartschool_mobile/modules/dashboard/widgets/bottom_nav_tab.dart';
import 'package:smartschool_mobile/modules/profile/controllers/profile_controller.dart';
import 'package:smartschool_mobile/modules/report/controllers/report_controller.dart';
import 'package:smartschool_mobile/modules/report/views/report_screen.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';
import 'package:smartschool_mobile/routes/routes.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedPosition = 0;

  final DashBoardController _dashBoardController =
      Get.put(DashBoardController());

  final ProfileController _profileController = Get.put(ProfileController());

  final ReportController _reportController = Get.put(ReportController());
  late FirebaseMessaging messaging;

  late final GetIndayAttendanceController _getIndayAttendanceController =
      Get.put(GetIndayAttendanceController());

  @override
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;

    messaging.getInitialMessage();

    //foreground state
    FirebaseMessaging.onMessage.listen((message) {
      //display notification dialog
      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          title: Center(
            child: Text(
              '${message.data['message']}',
              style: TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Môn học: ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: message.data['course'] == null
                                ? "Không có dữ liệu"
                                : '${message.data['course']}',
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Phòng học: ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: message.data['room'] == null
                                ? "Không có dữ liệu"
                                : '${message.data['room']}',
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Ca học: ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: message.data['shift'] == null
                                ? 'Không có dữ liệu'
                                : formatUtcToLocalTime(message.data['shift']
                                        .toString()
                                        .substring(0, 18)) +
                                    '-' +
                                    formatUtcToLocalTime(message.data['shift']
                                        .toString()
                                        .substring(20)),
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Điểm danh lúc: ',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: message.data['checkintime'] == null
                                ? "Không có dữ liệu"
                                : formatUtcToLocalTime(
                                    message.data['checkintime']),
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              )),
          actions: [
            TextButton(
              child: Text("Đóng",
                  style: TextStyle(
                      fontSize: 12.0.sp, color: Colors.blue.shade900)),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    });

    updateNotiToken();
  }

  void updateNotiToken() {
    messaging.getToken().then((value) {
      _dashBoardController.fcmToken.value = value!;
      _dashBoardController
          .updateNotificationToken(_dashBoardController.fcmToken.value);
    });
  }

  void testNoti() {
    _dashBoardController.testNotification();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            floatingActionButton: SizedBox(
              width: 16.0.w,
              height: 16.0.h,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () =>
                      Get.toNamed(Routes.dashboard + Routes.qrcode),
                  backgroundColor: Colors.blue.shade900,
                  child: const Icon(
                    Icons.qr_code_2,
                    size: 37,
                  ),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildBottomTab(),
            appBar: (selectedPosition == 0)
                ? (AppBar(
                    title: Text(
                      'Trang chủ',
                      style: TextStyle(
                          fontSize: 17.0.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2),
                    ),
                    actions: [
                      IconButton(
                        // ignore: avoid_returning_null_for_void
                        onPressed: () {
                          Get.toNamed(Routes.dashboard + Routes.notification);
                        },
                        icon: const Icon(Icons.notifications),
                        color: Colors.blue.shade900,
                        iconSize: 18.0.sp,
                      ),
                    ],
                    leading: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.blue.shade900,
                        size: 18.0.sp,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.dashboard + Routes.settings);
                      },
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ))
                : (AppBar(
                    title: Text(
                      'Báo cáo',
                      style: TextStyle(
                          fontSize: 18.0.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )),
            body: Container(
                decoration: const BoxDecoration(color: Colors.white70),
                child: SafeArea(
                    child: IndexedStack(
                  index: selectedPosition,
                  children: [
                    _dashboardScreen(),
                    const ReportScreen(),
                  ],
                )))),
        onWillPop: () async {
          if (selectedPosition == 1) {
            setState(() {
              selectedPosition = 0;
            });
            return false;
          } else if (selectedPosition == 0) {
            return true;
          }
          return true;
        });
  }

  Widget _dashboardScreen() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Obx(() => Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        "Xin chào, ",
                        style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                          child: Text(_profileController.userName.value,
                              style: TextStyle(
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red[300])))
                    ],
                  ),
                ))),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            "Điểm danh hôm nay",
            style: TextStyle(
                fontSize: 15.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w700),
          ),
        ),
        Obx(() {
          if (_getIndayAttendanceController.isLoading.isTrue) {
            return Center(
              child: SpinKitFadingFour(
                color: Colors.blue.shade900,
                size: 40.0.sp,
              ),
            );
          } else if (_getIndayAttendanceController
              .indayAttendanceList.isEmpty) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_schedule_today.gif',
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                          child: Text(
                        'Bạn không có ca học nào! ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.8,
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w600),
                      )))
                ],
              ),
            );
          } else {
            return Expanded(
                child: SizedBox(
              height: 100.0,
              child: ListView.builder(
                  itemCount:
                      _getIndayAttendanceController.indayAttendanceList.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      child: CheckinTodayItem(
                          startTime: formatDate(_getIndayAttendanceController.indayAttendanceList[index]['start_time'])
                              .substring(10),
                          endTime: formatDate(_getIndayAttendanceController.indayAttendanceList[index]['end_time'])
                              .substring(10),
                          date: _getIndayAttendanceController.indayAttendanceList[index]
                                      ['check_in_time'] ==
                                  null
                              ? ""
                              : formatDate(_getIndayAttendanceController.indayAttendanceList[index]['check_in_time'])
                                  .substring(0, 10),
                          time: _getIndayAttendanceController.indayAttendanceList[index]
                                      ['check_in_time'] ==
                                  null
                              ? "--/--"
                              : "Điểm danh lúc: " +
                                  formatDate(_getIndayAttendanceController.indayAttendanceList[index]['check_in_time'])
                                      .substring(10),
                          course: _getIndayAttendanceController.indayAttendanceList[index]['course'],
                          room: _getIndayAttendanceController.indayAttendanceList[index]['room'],
                          status: _getIndayAttendanceController.indayAttendanceList[index]['check_in_status'] == "" ? checkStatusCheckin(_getIndayAttendanceController.indayAttendanceList[index]['end_time']) : convertCheckinTodayStatus(_getIndayAttendanceController.indayAttendanceList[index]['check_in_status'])),
                    );
                  })),
            ));
          }
        })
      ],
    );
  }

  Widget _buildBottomTab() {
    return Container(
      decoration: const BoxDecoration(),
      child: BottomAppBar(
        color: Colors.grey.shade100,
        // shape: const CircularNotchedRectangle(),
        notchMargin: 5,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavTab(
              title: 'home'.tr,
              icon: Icons.home,
              isSelected: selectedPosition == 0,
              onTap: () {
                _getIndayAttendanceController.getIndayAttendance();
                setState(() {
                  selectedPosition = 0;
                });
              },
            ),
            BottomNavTab(
              title: 'report'.tr,
              icon: Icons.bar_chart,
              isSelected: selectedPosition == 1,
              onTap: () {
                _reportController.getUserSemestersList();
                setState(() {
                  selectedPosition = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatUtcToLocalTime(String? dateUtc) {
    if (dateUtc != null) {
      DateTime date =
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true).toLocal();
      var inputDate = DateTime.parse(date.toString());
      var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    }
    return "";
  }

  String formatDate(String date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String checkStatusCheckin(String endTime) {
    DateTime now = DateTime.now();
    DateTime endTimeConvert = DateTime.parse(endTime).toLocal();
    if (now.compareTo(endTimeConvert) > 0) {
      return "Vắng";
    } else {
      return "Chưa điểm danh";
    }
  }

  String convertCheckinTodayStatus(String status) {
    if (status == "Late") {
      return "Đi trễ";
    } else {
      return "Hợp lệ";
    }
  }
}
