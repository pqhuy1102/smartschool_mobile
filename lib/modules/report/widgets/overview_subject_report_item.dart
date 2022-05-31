import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OverviewSubjectItem extends StatelessWidget {
  const OverviewSubjectItem(
      {Key? key,
      required this.subjectName,
      required this.subjectId,
      required this.className,
      required this.totalSession,
      required this.validSession,
      required this.absenceSession,
      required this.lateSession})
      : super(key: key);
  final String subjectName;
  final int validSession;
  final int absenceSession;
  final int lateSession;
  final int totalSession;
  final String className;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        padding: const EdgeInsets.fromLTRB(0, 20, 8, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade900, width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(65)),
              child: Icon(
                Icons.collections_bookmark,
                color: Colors.blue.shade900,
                size: 24.0.sp,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // ignore: unnecessary_string_interpolations
                    '$subjectId - $className',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    // ignore: unnecessary_string_interpolations
                    '$subjectName',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: unnecessary_string_interpolations
                      Text(
                        '• Số buổi hợp lệ',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '$validSession' '/' '$totalSession ' 'buổi',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: unnecessary_string_interpolations
                      Text(
                        '• Số buổi vắng',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '$absenceSession' '/' '$totalSession ' 'buổi',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: unnecessary_string_interpolations
                      Text(
                        '• Số buổi trễ',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '$lateSession' '/' '$totalSession ' 'buổi',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
