import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/complain/controllers/complain_controller.dart';
import 'package:smartschool_mobile/routes/routes.dart';

class DetailSubjectItem extends StatelessWidget {
  DetailSubjectItem(
      {Key? key,
      required this.scheduleId,
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
  final int scheduleId;

  final ComplainController _complainController = Get.put(ComplainController());

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

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
                      fontSize:
                          textScale > 1.4 ? 14.0.sp / textScale * 1.4 : 14.0.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600),
                ),
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
                          fontSize: textScale > 1.4
                              ? 14.0.sp / textScale * 1.4
                              : 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.blue.shade900,
                        size: 14.0.sp,
                      ),
                      const SizedBox(
                        width: 2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text("• $status",
                      style: TextStyle(
                          fontSize: textScale > 1.4
                              ? 14.0.sp / textScale * 1.4
                              : 14.0.sp,
                          color: status == "Hợp lệ"
                              ? Colors.green.shade600
                              : status == "Đi trễ"
                                  ? Colors.orange.shade600
                                  : Colors.red.shade600,
                          fontWeight: FontWeight.w600)),
                ),
                status != "Hợp lệ"
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0.sp),
                          ),
                        ),
                        onPressed: () {
                          _complainController.getComplainForm(scheduleId);
                          Get.toNamed(Routes.addComplain);
                        },
                        child: Text("Phản ánh",
                            style: TextStyle(
                                fontSize: textScale > 1.4
                                    ? 14.0.sp / textScale * 1.4
                                    : 14.0.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)))
                    : const Text("")
              ],
            )
          ],
        ));
  }
}
