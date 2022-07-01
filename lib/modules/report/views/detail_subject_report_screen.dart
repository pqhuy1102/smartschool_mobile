import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/report/controllers/report_controller.dart';
import 'package:smartschool_mobile/modules/report/widgets/detail_subject_report_item.dart';

class SubjectDetailReportScreen extends StatelessWidget {
  SubjectDetailReportScreen({Key? key}) : super(key: key);
  final ReportController _reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue.shade900,
            size: 18.0.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Báo cáo chi tiết',
          style: TextStyle(
              fontSize: 17.0.sp,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SafeArea(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_alt,
                        color: Colors.grey.shade600,
                        size: 13.0.sp,
                      ),
                      Text(
                        "Lọc danh sách",
                        style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Obx(() {
                    return DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Tất cả',
                            style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Hợp lệ',
                            style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          value: "2",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Đi trễ',
                            style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          value: "3",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Vắng',
                            style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          value: "4",
                        ),
                      ],
                      value: _reportController.filterValue.value,
                      onChanged: (selectedValue) {
                        _reportController.filterValue.value =
                            selectedValue.toString();
                        _reportController.filterCourseAttendanceFun(
                            selectedValue.toString());
                      },
                    );
                  })
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
              children: [
                Obx(() {
                  if (_reportController.isLoading.value) {
                    return Center(
                      child: SpinKitFadingFour(
                        color: Colors.blue.shade900,
                        size: 40.0.sp,
                      ),
                    );
                  } else if (_reportController.filterCourseAttendance.isEmpty) {
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
                    return Expanded(
                        child: ListView.builder(
                            itemCount:
                                _reportController.filterCourseAttendance.length,
                            itemBuilder: ((context, index) {
                              return DetailSubjectItem(
                                  startTime: formatDateTime(_reportController
                                          .filterCourseAttendance[index]
                                          .startTime)
                                      .substring(10),
                                  endTime:
                                      formatDateTime(_reportController.filterCourseAttendance[index].endTime)
                                          .substring(10),
                                  date: _reportController.filterCourseAttendance[index].checkInTime == null
                                      ? formatDate(_reportController
                                          .filterCourseAttendance[index]
                                          .startTime
                                          .toString()
                                          .substring(0, 10))
                                      : formatDateTime(_reportController
                                          .filterCourseAttendance[index]
                                          .checkInTime),
                                  subjectId: _reportController.selectedCourse.value,
                                  className: "",
                                  room: "${_reportController.filterCourseAttendance[index].room}",
                                  status: _reportController.filterCourseAttendance[index].checkInStatus == "Attend"
                                      ? "Hợp lệ"
                                      : _reportController.filterCourseAttendance[index].checkInStatus == "Late"
                                          ? "Đi trễ"
                                          : "Vắng");
                            })));
                  }
                })
              ],
            ))
          ],
        )),
      ),
    );
  }

  String formatDate(date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String formatDateTime(String date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
