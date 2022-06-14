import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailSubjectItem extends StatelessWidget {
  const DetailSubjectItem(
      {Key? key,
      required this.date,
      required this.subjectId,
      required this.className,
      required this.room,
      required this.status,
      required this.startTime,
      required this.endTime})
      : super(key: key);
  final String date;
  final String subjectId;
  final String className;
  final String room;
  final String status;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade900, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // ignore: unnecessary_string_interpolations
                  "$date",
                  style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey.shade600,
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      // ignore: unnecessary_string_interpolations
                      "$subjectId",
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Row(
                    children: [
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
                  const SizedBox(
                    width: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue.shade900,
                        size: 14.0.sp,
                      ),
                      // ignore: unnecessary_string_interpolations
                      Text("$room",
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text("• $status",
                  style: TextStyle(
                      fontSize: 14.0.sp,
                      color: status == "Hợp lệ"
                          ? Colors.green.shade600
                          : status == "Đi trễ"
                              ? Colors.orange.shade600
                              : Colors.red.shade600,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ));
  }
}
