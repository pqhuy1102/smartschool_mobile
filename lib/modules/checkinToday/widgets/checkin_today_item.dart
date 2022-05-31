import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/routes/routes.dart';

class CheckinTodayItem extends StatelessWidget {
  const CheckinTodayItem(
      {Key? key,
      required this.date,
      required this.time,
      required this.subjectId,
      required this.className,
      required this.room,
      required this.endTime,
      required this.startTime,
      required this.status})
      : super(key: key);
  final String date;
  final String time;
  final String subjectId;
  final String className;
  final String room;
  final String status;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade900, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // ignore: unnecessary_string_interpolations
              "$time $date",
              style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500),
            ),
            // ignore: unnecessary_string_interpolations

            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // ignore: unnecessary_string_interpolations
                    "$subjectId - $className",
                    style: TextStyle(
                        fontSize: 18.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //           vertical: 4, horizontal: 6),
                  //       primary: Colors.red,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(4.0.sp),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Get.toNamed(Routes.addComplain);
                  //     },
                  //     child: Text("Phản ánh",
                  //         style: TextStyle(
                  //             fontSize: 16.0.sp,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600)))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.blue.shade900,
                          size: 30,
                        ),

                        // ignore: unnecessary_string_interpolations
                        Text("$startTime-$endTime",
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue.shade900,
                        size: 30,
                      ),
                      // ignore: unnecessary_string_interpolations
                      Text("$room",
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 6),
              child: Text("• $status",
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      color: status == "Attend"
                          ? Colors.green.shade700
                          : Colors.red.shade600,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ));
  }
}
