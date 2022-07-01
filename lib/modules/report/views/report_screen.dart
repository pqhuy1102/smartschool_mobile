import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/report/controllers/report_controller.dart';
import 'package:smartschool_mobile/modules/report/widgets/overview_subject_report_item.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportController _reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            //
            body: Container(
              decoration: const BoxDecoration(color: Colors.white70),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Học kỳ',
                            style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600),
                          ),
                          Obx(() {
                            return SizedBox(
                                width: 50.0.w,
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
                                    value: _reportController
                                        .currentSemesterValue.value,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 30,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    items: _reportController.userSemestersList
                                        .map((sem) {
                                      return DropdownMenuItem(
                                        child: Center(
                                          child: Text(
                                            "${sem['title']} ${sem['year']}",
                                            style: TextStyle(
                                                fontSize: 13.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        value: sem['id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _reportController.currentSemesterValue
                                          .value = value.toString();

                                      _reportController.getCoursesInSemester();
                                    },
                                  ),
                                ));
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      if (_reportController.userCoursesList.isEmpty) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images/no_data.gif',
                            ),
                            Center(
                                child: Text(
                              'Danh sách trống! ',
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        );
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                itemCount:
                                    _reportController.userCoursesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: OverviewSubjectItem(
                                      subjectName:
                                          "${_reportController.userCoursesList[index]['name']}",
                                      validSession: _reportController
                                          .userCoursesList[index]['attendance'],
                                      absenceSession: _reportController
                                          .userCoursesList[index]['absence'],
                                      totalSession: _reportController
                                          .userCoursesList[index]['total'],
                                      subjectId:
                                          "${_reportController.userCoursesList[index]['course_id']}",
                                    ),
                                    onTap: () {
                                      _reportController.getCourseAttendance(
                                          _reportController
                                              .userCoursesList[index]['id']
                                              .toString());
                                      Get.toNamed(Routes.subjectDetailReport);
                                    },
                                  );
                                }));
                      }
                    })
                  ],
                ),
              ),
            )));
  }
}
