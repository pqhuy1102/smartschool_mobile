import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.icon,
    required this.isSeen,
    required this.title,
    required this.content,
    required this.date,
  }) : super(key: key);

  final IconData icon;
  final bool isSeen;
  final String title;
  final String content;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSeen ? Colors.white : const Color.fromARGB(255, 224, 240, 255),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 65,
            // width: 65,
            margin: const EdgeInsets.only(bottom: 14, top: 35, right: 14),
            // decoration: BoxDecoration(
            //     color: Colors.blue.shade100,
            //     borderRadius: BorderRadius.circular(65)),
            child: Icon(
              icon,
              color: Colors.blue.shade900,
              size: 30.sp,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                // ignore: unnecessary_string_interpolations
                "$title",
                style:
                    TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Flexible(
                  child: Wrap(
                children: [
                  Text(
                    // ignore: unnecessary_string_interpolations
                    "$content",
                    style: TextStyle(fontSize: 12.0.sp),
                  ),
                ],
              )),
              const SizedBox(
                height: 6,
              ),
              // ignore: unnecessary_string_interpolations
              Text("$date",
                  style:
                      TextStyle(fontSize: 12.0.sp, color: Colors.grey.shade600))
            ],
          ))
        ],
      ),
    );
  }
}
