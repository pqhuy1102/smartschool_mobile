import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/report/widgets/particular_subject_report.dart';

class SubjectDetailReportScreen extends StatelessWidget {
  const SubjectDetailReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
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
          'Báo cáo chi tiết',
          style: TextStyle(
              fontSize: 26.0.sp,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_alt,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      "Lọc danh sách",
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                DropdownButton(items: [
                  DropdownMenuItem(
                    child: Text(
                      'Tất cả',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    value: "1",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Hợp lệ',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    value: "2",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Vắng',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    value: "3",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Đi trễ',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    value: "4",
                  ),
                ], value: "1", onChanged: (selectedValue) {}),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: const [
                ParticularSubjectReport(
                    date: "28/04/2022",
                    subjectId: "CM101",
                    className: "18CTT1",
                    room: "I.41",
                    status: "Vắng"),
                ParticularSubjectReport(
                    date: "28/04/2022",
                    subjectId: "CM101",
                    className: "18CTT1",
                    room: "I.41",
                    status: "Hợp lệ")
              ],
            ))
          ],
        )),
      ),
    ));
  }
}
