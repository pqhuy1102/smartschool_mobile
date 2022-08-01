import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScheduleIndayItem extends StatelessWidget {
  const ScheduleIndayItem({
    Key? key,
    required this.course,
    required this.room,
    required this.endTime,
    required this.startTime,
  }) : super(key: key);
  final String course;
  final String room;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade900, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          fontSize: textScale > 1.4
                              ? 14.0.sp / textScale * 1.4
                              : 14.0.sp,
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
                          width: 1,
                        ),
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.blue.shade900,
                          size: 14.0.sp,
                        ),

                        // ignore: unnecessary_string_interpolations
                        Flexible(
                            child: Text("$startTime -$endTime",
                                style: TextStyle(
                                    fontSize: textScale > 1.4
                                        ? 14.0.sp / textScale * 1.4
                                        : 14.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.room_rounded,
                        color: Colors.blue.shade900,
                        size: 16.0.sp,
                      ),
                      // ignore: unnecessary_string_interpolations
                      Text(" $room",
                          style: TextStyle(
                              fontSize: textScale > 1.4
                                  ? 14.0.sp / textScale * 1.4
                                  : 14.0.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
