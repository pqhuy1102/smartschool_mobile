import 'package:flutter/material.dart';

import 'package:smartschool_mobile/modules/report/widgets/detail_subject.dart';

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
              decoration: BoxDecoration(color: Colors.indigo.shade50),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Học kỳ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(items: const [
                          DropdownMenuItem(
                            child: Text(
                              'HK1 2021-2022',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'HK2 2021-2022',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "2",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'HK3 2021-2022',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: "3",
                          ),
                        ], value: "1", onChanged: (selectedValue) {}),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Expanded(
                        child: ListView(
                      children: const [
                        DetailSubject(
                          subjectName: 'CM101 - Communication',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                        ),
                        DetailSubject(
                          subjectName: 'CM163 - Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                        ),
                        DetailSubject(
                          subjectName: 'CM163 - Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                        ),
                        DetailSubject(
                          subjectName: 'CM163 - Computer Hardware',
                          validSession: 1,
                          absenceSession: 2,
                          lateSession: 1,
                          totalSession: 20,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )));
  }
}
