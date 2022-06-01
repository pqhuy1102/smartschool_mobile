import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:smartschool_mobile/modules/dashboard/widgets/checkin_time_items.dart';
import 'package:smartschool_mobile/modules/dashboard/widgets/dashboard_items.dart';
import 'package:smartschool_mobile/modules/dashboard/widgets/bottom_nav_tab.dart';
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
  final AuthenticationManager _authenticationManager =
      Get.put(AuthenticationManager());
  final DashBoardController _dashBoardController =
      Get.put(DashBoardController());
  final LoginController _loginController = Get.put(LoginController());
  late FirebaseMessaging messaging;

  final shift = "2022-06-01 09:55:22-2022-06-01 11:55:22";

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
      print(_dashBoardController.fcmToken.value);
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
        child: SafeArea(
            child: Scaffold(
                floatingActionButton: SizedBox(
                  width: 18.0.w,
                  height: 18.0.h,
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
                          'SmartSchool',
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2),
                        ),
                        actions: [
                          IconButton(
                            // ignore: avoid_returning_null_for_void
                            onPressed: () {
                              Get.toNamed(
                                  Routes.dashboard + Routes.notification);
                            },
                            icon: const Icon(Icons.notifications),
                            color: Colors.blue.shade900,
                            iconSize: 30.0.sp,
                          ),
                        ],
                        leading: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.blue.shade900,
                            size: 26.0.sp,
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
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue.shade900,
                            size: 24.0.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPosition = 0;
                            });
                          },
                        ),
                        title: Text(
                          'Báo cáo',
                          style: TextStyle(
                              fontSize: 26.sp,
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
                    ))))),
        onWillPop: () async {
          if (selectedPosition == 1) {
            setState(() {
              selectedPosition = 0;
            });
            return false;
          } else {
            return true;
          }
        });
  }

  Widget _dashboardScreen() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Obx(() => Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                    text: 'hello'.tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: _authenticationManager.username.value == ""
                              ? '${_loginController.username}'
                              : '${_authenticationManager.username}',
                          style: TextStyle(
                              fontSize: 18.5.sp, fontWeight: FontWeight.bold))
                    ]),
              ))),
        ),

        Container(
          height: 18.0.h,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'latest checkin'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                        child: const CheckinTimeItem(
                          title: '7:30',
                          icon: Icons.arrow_drop_down,
                          status: 'in',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                        child: const CheckinTimeItem(
                          title: 'I.44',
                          icon: Icons.room,
                          status: 'room',
                        ),
                      ),
                      const CheckinTimeItem(
                        title: '15/02/2022',
                        icon: Icons.date_range,
                        status: 'date',
                      ),
                    ],
                  )
                ],
              )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade900,
          ),
        ),

        //Dashboard element
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            children: [
              InkWell(
                child: DashBoardItem(
                  title: 'checkin today'.tr,
                  icon: Icons.date_range_sharp,
                  color: const Color.fromARGB(255, 4, 170, 9),
                  iconBackground: Colors.green.shade100,
                ),
                onTap: () {
                  Get.toNamed(Routes.dashboard + Routes.checkinToday);
                },
              ),
              DashBoardItem(
                title: 'absence'.tr,
                icon: Icons.person_off,
                color: const Color.fromARGB(255, 255, 17, 0),
                iconBackground: Colors.red.shade100,
              ),
              InkWell(
                child: DashBoardItem(
                  title: 'late/earlier'.tr,
                  icon: Icons.timer_outlined,
                  color: const Color.fromARGB(255, 0, 140, 255),
                  iconBackground: Colors.blue.shade100,
                ),
              ),
            ],
          ),
        )
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
}
