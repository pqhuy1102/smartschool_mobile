import 'package:flutter/material.dart';

class DetailSubject extends StatelessWidget {
  const DetailSubject(
      {Key? key,
      required this.subjectName,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade600)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                // ignore: unnecessary_string_interpolations
                '$subjectName',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: unnecessary_string_interpolations
              const Text(
                'Số buổi đi học hợp lệ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                '$validSession' '/' '$totalSession ' 'buổi',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              const Text(
                'Số buổi vắng',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                '$absenceSession' '/' '$totalSession ' 'buổi',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              const Text(
                'Số buổi đi học trễ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                '$lateSession' '/' '$totalSession ' 'buổi',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}
