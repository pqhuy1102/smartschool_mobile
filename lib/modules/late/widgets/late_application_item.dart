import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/late/controllers/late_controller.dart';

class LateApplicationItem extends StatelessWidget {
  LateApplicationItem(
      {Key? key,
      required this.courseName,
      required this.formId,
      required this.createTime,
      required this.currentStatus,
      required this.formStatus,
      required this.requestStatus,
      required this.teacherName})
      : super(key: key);
  final String createTime;
  final String courseName;
  final String teacherName;
  final String currentStatus;
  final String requestStatus;
  final String formStatus;
  final int formId;

  final LateController _lateController = Get.put(LateController());

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        padding: const EdgeInsets.fromLTRB(16, 10, 6, 10),
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
                  createTime,
                  style: TextStyle(
                      fontSize: textScale >= 1.3
                          ? 13.0.sp / textScale * 1.3
                          : 13.0.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600),
                ),
                formStatus == "Đang chờ duyệt"
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0.sp),
                          ),
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                              title:
                                  'Bạn chắc chắn muốn hủy đơn xin phép đã tạo?',
                              titleStyle: TextStyle(
                                  fontSize: textScale > 1.4
                                      ? 14.0.sp / textScale * 1.4
                                      : 14.0.sp,
                                  fontWeight: FontWeight.w700),
                              middleText:
                                  'Đơn xin phép sẽ bị hủy sau khi bạn chọn “Hủy” phản ánh này.',
                              middleTextStyle: TextStyle(
                                  fontSize: textScale > 1.4
                                      ? 13.0.sp / textScale * 1.4
                                      : 13.0.sp,
                                  fontWeight: FontWeight.w500),
                              backgroundColor: Colors.white,
                              radius: 10.0,
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    _lateController.deleteLateForm(formId);
                                  },
                                  child: Text(
                                    'Hủy',
                                    style: TextStyle(
                                        fontSize: textScale > 1.4
                                            ? 14.0.sp / textScale * 1.4
                                            : 14.0.sp,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red.shade600,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.0.sp),
                                    ),
                                  )),
                              cancel: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0.sp),
                                        side: BorderSide(
                                            color: Colors.blue.shade900)),
                                  ),
                                  onPressed: (() {
                                    Get.back();
                                  }),
                                  child: Text(
                                    'Đóng',
                                    style: TextStyle(
                                        fontSize: textScale > 1.4
                                            ? 14.0.sp / textScale * 1.4
                                            : 14.0.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade900),
                                  )),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 18));
                        },
                        child: Text("Hủy",
                            style: TextStyle(
                                fontSize: textScale >= 1.3
                                    ? 13.0.sp / textScale * 1.3
                                    : 13.0.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)))
                    : const Text("")
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      courseName,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: textScale >= 1.3
                              ? 14.0.sp / textScale * 1.3
                              : 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      // ignore: unnecessary_string_interpolations
                      "Giảng viên:",
                      style: TextStyle(
                          fontSize: textScale >= 1.3
                              ? 11.0.sp / textScale * 1.3
                              : 11.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      teacherName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: textScale >= 1.3
                              ? 11.0.sp / textScale * 1.3
                              : 11.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                      height: 40,
                      width:
                          requestStatus == "Vắng có phép (Hợp lệ)" ? 240 : 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade700, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(requestStatus,
                            style: TextStyle(
                                fontSize: textScale >= 1.3
                                    ? 12.0.sp / textScale * 1.3
                                    : 12.0.sp,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600)),
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Text("• $formStatus",
                      style: TextStyle(
                          fontSize: textScale >= 1.3
                              ? 13.0.sp / textScale * 1.3
                              : 13.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            )
          ],
        ));
  }
}
