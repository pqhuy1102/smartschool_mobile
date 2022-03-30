import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:smartschool_mobile/modules/report/widgets/detail_subject.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Học kỳ',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                        DropdownButton(items: [
                          DropdownMenuItem(
                            child: Text(
                              'HK1 2021-2022',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'HK2 2021-2022',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "2",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'HK3 2021-2022',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "3",
                          ),
                        ], value: "1", onChanged: (selectedValue) {}),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        InkWell(
                          child: const DetailSubject(
                            subjectName: 'Communication',
                            validSession: 1,
                            absenceSession: 2,
                            lateSession: 1,
                            totalSession: 20,
                            className: "18CTT1",
                            subjectId: "CM101",
                          ),
                          onTap: () {
                            Get.toNamed(Routes.subjectDetailReport);
                          },
                        ),
                        const DetailSubject(
                          subjectName: 'Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                          className: "18CTT1",
                          subjectId: "CM101",
                        ),
                        const DetailSubject(
                          subjectName: 'Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                          className: "18CTT1",
                          subjectId: "CM63",
                        ),
                        const DetailSubject(
                          subjectName: 'Introduction to Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                          className: "18CTT1",
                          subjectId: "CM163",
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )));
  }
}
