import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OverviewSubjectItem extends StatelessWidget {
  const OverviewSubjectItem({
    Key? key,
    required this.subjectName,
    required this.subjectId,
    required this.totalSession,
    required this.validSession,
    required this.absenceSession,
  }) : super(key: key);
  final String subjectName;
  final int validSession;
  final int absenceSession;
  final int totalSession;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        padding: const EdgeInsets.fromLTRB(0, 20, 8, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade900, width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    size: 20.0.sp,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // ignore: unnecessary_string_interpolations
                        '$subjectId - $subjectName',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 16, right: 18),
                child: textScale >= 1.3
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• Số buổi đi học:',
                            style: TextStyle(
                                fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                            maxLines: 2,
                          ),
                          Text(
                            '$validSession'
                            '/'
                            '$totalSession '
                            'buổi',
                            style: TextStyle(
                                fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '• Số buổi đi học:',
                            style: TextStyle(
                                fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              '$validSession'
                              '/'
                              '$totalSession '
                              'buổi',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 18),
              child: textScale >= 1.3
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• Số buổi vắng:',
                          style: TextStyle(
                              fontSize: 14.0.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '$absenceSession' '/' '$totalSession ' 'buổi',
                          style: TextStyle(
                              fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '• Số buổi vắng:',
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
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
