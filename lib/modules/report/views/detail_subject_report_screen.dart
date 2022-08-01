import 'package:dropdown_button2/dropdown_button2.dart';
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
    final textScale = MediaQuery.of(context).textScaleFactor;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

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
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(child: Obx(() {
            if (_reportController.hasInternet.isFalse) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/lost_internet.jpg',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Không có kết nối, vui lòng thử lại!',
                        style: TextStyle(
                          fontSize: textScale > 1.4
                              ? 13.0.sp / textScale * 1.3
                              : 13.0.sp,
                          color: Colors.grey.shade700,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text(
                        "Tải lại",
                        style: TextStyle(
                            fontSize: textScale > 1.4
                                ? 13.0.sp / textScale * 1.4
                                : 13.0.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        // onSurface: Colors.transparent,
                        // shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 45),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                      onPressed: () {
                        _reportController.getUserSemestersList();
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Column(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                "Lọc danh sách",
                                style: TextStyle(
                                    fontSize: (textScale > 1.4
                                        ? 13.0.sp / textScale * 1.4
                                        : 13.0.sp),
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Obx(() {
                          return SizedBox(
                              width: textScale > 1.2 ? 36.0.w : 30.0.w,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blueGrey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(8)),
                                child: DropdownButtonFormField2(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  isExpanded: true,
                                  value: _reportController.filterValue.value,
                                  onChanged: (selectedValue) {
                                    _reportController.filterValue.value =
                                        selectedValue.toString();
                                    _reportController.filterCourseAttendanceFun(
                                        selectedValue.toString());
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 28,
                                  buttonHeight: shortestSide > 600 ? 50 : 28,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          'Tất cả',
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 12.0.sp / textScale * 1.4
                                                  : 12.0.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: "1",
                                    ),
                                    DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          'Hợp lệ',
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 12.0.sp / textScale * 1.4
                                                  : 12.0.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: "2",
                                    ),
                                    DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          'Đi trễ',
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 12.0.sp / textScale * 1.4
                                                  : 12.0.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: "3",
                                    ),
                                    DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          'Vắng',
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 12.0.sp / textScale * 1.4
                                                  : 12.0.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: "4",
                                    ),
                                  ],
                                ),
                              ));
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
                        } else if (_reportController
                            .filterCourseAttendance.isEmpty) {
                          return Column(
                            children: [
                              Image.asset(
                                'assets/images/no_data.gif',
                              ),
                              Center(
                                  child: Text(
                                'Danh sách trống! ',
                                style: TextStyle(
                                    fontSize: textScale > 1.4
                                        ? 13.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                            ],
                          );
                        } else {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: _reportController
                                      .filterCourseAttendance.length,
                                  itemBuilder: ((context, index) {
                                    return DetailSubjectItem(
                                        scheduleId: _reportController
                                            .filterCourseAttendance[index]
                                            .scheduleId,
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
              );
            }
          })),
        ));
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
