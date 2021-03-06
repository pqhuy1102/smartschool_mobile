import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';
import 'package:smartschool_mobile/modules/checkinToday/widgets/checkin_today_item.dart';
import 'package:intl/intl.dart';

class CheckinTodayScreen extends GetView<GetIndayAttendanceController> {
  CheckinTodayScreen({Key? key}) : super(key: key);
  final f = DateFormat('dd/MM/yyyy HH:mm');

  late final GetIndayAttendanceController _getIndayAttendanceController =
      Get.put(GetIndayAttendanceController());

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
            body: SafeArea(child: Obx(() {
              if (_getIndayAttendanceController.indayAttendanceList.isEmpty) {
                return Column(
                  children: [
                    Image.asset(
                      'assets/images/no_data.gif',
                    ),
                    Center(
                        child: Text(
                      'Danh sách trống! ',
                      style: TextStyle(
                          fontSize: 16.0.sp, fontWeight: FontWeight.w600),
                    ))
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: _getIndayAttendanceController
                        .indayAttendanceList.length,
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
                            status: _getIndayAttendanceController.indayAttendanceList[index]['check_in_status'] == "" ? "Chưa điểm danh" : _getIndayAttendanceController.indayAttendanceList[index]['check_in_status']),
                      );
                    }));
              }
            }))));
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
