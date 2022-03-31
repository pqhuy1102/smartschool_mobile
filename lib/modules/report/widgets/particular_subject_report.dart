import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ParticularSubjectReport extends StatelessWidget {
  const ParticularSubjectReport(
      {Key? key,
      required this.date,
      required this.subjectId,
      required this.className,
      required this.room,
      required this.status})
      : super(key: key);
  final String date;
  final String subjectId;
  final String className;
  final String room;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
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
                  style:
                      TextStyle(fontSize: 14.0.sp, color: Colors.grey.shade600),
                ),
                InkWell(
                  child: Text("Phản ánh",
                      style: TextStyle(
                          fontSize: 16.0.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w600)),
                  onTap: () {},
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
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
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue.shade900,
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
                          : Colors.red.shade600,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ));
  }
}
