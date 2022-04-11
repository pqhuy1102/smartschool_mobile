import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';
import 'package:smartschool_mobile/modules/checkinToday/widgets/checkin_today_item.dart';

class CheckinTodayScreen extends GetView<GetIndayAttendanceController> {
  const CheckinTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                'Điểm danh hôm nay',
                style: TextStyle(
                    fontSize: 22.0.sp,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
                child: controller.obx((data) => ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: ((context, index) {
                      return CheckinTodayItem(
                          date: data[index]['check_in_time'],
                          time: "9:35",
                          subjectId: "CS101",
                          className: "18CTT1",
                          room: data[index]['room'],
                          status: "Thành công");
                    }))))));
  }
}
