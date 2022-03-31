import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          fontSize: 26.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                    actions: [
                      IconButton(
                        // ignore: avoid_returning_null_for_void
                        onPressed: () {
                          Get.toNamed(Routes.dashboard + Routes.notification);
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
                )))));
  }

  Widget _dashboardScreen() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                    text: 'Xin chào, ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'Nguyễn Văn A',
                          style: TextStyle(
                              fontSize: 18.5.sp, fontWeight: FontWeight.bold))
                    ]),
              )),
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
                    'Điểm danh mới nhất:',
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
                  title: 'Điểm danh hôm nay',
                  icon: Icons.date_range_sharp,
                  color: const Color.fromARGB(255, 4, 170, 9),
                  iconBackground: Colors.green.shade100,
                ),
                onTap: () {
                  Get.toNamed(Routes.dashboard + Routes.checkinToday);
                },
              ),
              DashBoardItem(
                title: 'Nghỉ phép',
                icon: Icons.person_off,
                color: const Color.fromARGB(255, 255, 17, 0),
                iconBackground: Colors.red.shade100,
              ),
              InkWell(
                child: DashBoardItem(
                  title: 'Đi trễ/về sớm',
                  icon: Icons.timer_outlined,
                  color: const Color.fromARGB(255, 0, 140, 255),
                  iconBackground: Colors.blue.shade100,
                ),
              ),
              DashBoardItem(
                title: 'Phản ánh',
                icon: Icons.report,
                color: const Color.fromARGB(255, 241, 157, 60),
                iconBackground: Colors.amber.shade100,
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
              title: 'Trang chủ',
              icon: Icons.home,
              isSelected: selectedPosition == 0,
              onTap: () {
                setState(() {
                  selectedPosition = 0;
                });
              },
            ),
            BottomNavTab(
              title: 'Báo cáo',
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
}
