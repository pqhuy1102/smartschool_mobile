import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';
import 'package:smartschool_mobile/modules/checkinToday/widgets/checkin_today_item.dart';
import 'package:intl/intl.dart';

class CheckinTodayScreen extends GetView<GetIndayAttendanceController> {
  CheckinTodayScreen({Key? key}) : super(key: key);
  final f = DateFormat('dd/MM/yyyy HH:mm');

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
                    fontSize: 20.0.sp,
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
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: CheckinTodayItem(
                            date: data[index]['check_in_time'] == null
                                ? ""
                                : formatDate(data[index]['check_in_time'])
                                    .substring(0, 10),
                            time: data[index]['check_in_time'] == null
                                ? ""
                                : formatDate(data[index]['check_in_time'])
                                    .substring(10),
                            subjectId: data[index]['course'],
                            className: "18CTT1",
                            room: data[index]['room'],
                            status: data[index]['check_in_status'] ??
                                "Chưa điểm danh"),
                      );
                    }))))));
  }

  String formatDate(String date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
