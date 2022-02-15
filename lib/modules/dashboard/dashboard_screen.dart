import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/dashboard/items/checkin_time_items.dart';
import 'package:smartschool_mobile/modules/dashboard/items/dashboard_items.dart';
import 'package:smartschool_mobile/modules/dashboard/tabs/bottom_nav_tab.dart';
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildBottomTab(),
            body: Container(
              decoration: BoxDecoration(color: Colors.indigo.shade50),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 18.h,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Điểm danh mới nhất:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 18, 0),
                                      child: const CheckinTimeItem(
                                        title: '7:30',
                                        icon: Icons.arrow_drop_up,
                                        status: 'in',
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 18, 0),
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
                    ],
                  ),
                  Expanded(
                      child: SizedBox(
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: const [
                        DashBoardItem(
                          title: 'Báo đi trễ',
                          icon: Icons.schedule,
                          color: Colors.red,
                        ),
                        DashBoardItem(
                          title: 'Báo nghỉ học',
                          icon: Icons.person_remove_alt_1_rounded,
                          color: Colors.orange,
                        ),
                        DashBoardItem(
                          title: 'Báo đi trễ',
                          icon: Icons.schedule,
                          color: Colors.red,
                        ),
                        DashBoardItem(
                          title: 'Báo đi trễ',
                          icon: Icons.schedule,
                          color: Colors.red,
                        ),
                        DashBoardItem(
                          title: 'Báo đi trễ',
                          icon: Icons.schedule,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }

  _buildBottomTab() {
    return Container(
      decoration: const BoxDecoration(),
      child: BottomAppBar(
        color: Colors.grey.shade200,
        // shape: const CircularNotchedRectangle(),
        notchMargin: 5,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavTab(
              title: 'Điểm danh',
              icon: Icons.calendar_today,
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
                Get.toNamed(Routes.dashboard + Routes.report);
                Timer(const Duration(seconds: 1), () {
                  setState(() {
                    selectedPosition = 0;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
