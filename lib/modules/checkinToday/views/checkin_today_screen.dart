import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/checkinToday/widgets/checkin_today_item.dart';

class CheckinTodayScreen extends StatelessWidget {
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
            child: Container(
                decoration: const BoxDecoration(color: Colors.white70),
                margin: const EdgeInsets.fromLTRB(10, 18, 10, 0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: const [
                        CheckinTodayItem(
                            date: "28/04/2022",
                            time: "9:35",
                            subjectId: "CS101",
                            className: "18CTT1",
                            room: "I.44",
                            status: "Thành công"),
                        CheckinTodayItem(
                            date: "28/04/2022",
                            time: "9:35",
                            subjectId: "CS101",
                            className: "18CTT1",
                            room: "I.44",
                            status: "Thất bại"),
                        CheckinTodayItem(
                            date: "28/04/2022",
                            time: "9:35",
                            subjectId: "CS101",
                            className: "18CTT1",
                            room: "I.44",
                            status: "Thành công"),
                      ],
                    )),
                  ],
                ))),
      ),
    );
  }
}
