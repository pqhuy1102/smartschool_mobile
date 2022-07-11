import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckinTodayItem extends StatelessWidget {
  const CheckinTodayItem(
      {Key? key,
      required this.date,
      required this.time,
      required this.course,
      required this.room,
      required this.endTime,
      required this.startTime,
      required this.status})
      : super(key: key);
  final String date;
  final String time;
  final String course;
  final String room;
  final String status;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
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
                  Flexible(
                    child: Text(
                      // ignore: unnecessary_string_interpolations
                      "$course",
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.blue.shade900,
                          size: 14.0.sp,
                        ),

                        // ignore: unnecessary_string_interpolations
                        Text("$startTime -$endTime",
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue.shade900,
                        size: 16.0.sp,
                      ),
                      // ignore: unnecessary_string_interpolations
                      Text(" $room",
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
            ),

            Container(
                margin: const EdgeInsets.only(top: 6),
                child: Text("• $status",
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        color: status == "Hợp lệ"
                            ? Colors.green.shade700
                            : status == "Đi trễ"
                                ? Colors.orange.shade700
                                : Colors.red,
                        fontWeight: FontWeight.w600)))
          ],
        ));
  }
}
