import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/complain/controllers/complain_controller.dart';

class DetailComplainFormScreen extends StatefulWidget {
  const DetailComplainFormScreen({Key? key}) : super(key: key);

  @override
  State<DetailComplainFormScreen> createState() =>
      _DetailComplainFormScreenState();
}

class _DetailComplainFormScreenState extends State<DetailComplainFormScreen> {
  final ComplainController _complainController = Get.put(ComplainController());

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue.shade900,
              size: 18.0.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Chi tiết phản ánh',
            style: TextStyle(
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx((() {
          if (_complainController.hasInternet.isFalse) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/lost_internet.jpg',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('Không có kết nối, vui lòng thử lại!',
                      style: TextStyle(
                        fontSize: textScale > 1.4
                            ? 13.0.sp / textScale * 1.3
                            : 13.0.sp,
                        color: Colors.grey.shade700,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Tải lại",
                      style: TextStyle(
                          fontSize: textScale > 1.4
                              ? 13.0.sp / textScale * 1.4
                              : 13.0.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      // onSurface: Colors.transparent,
                      // shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 45),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.sp),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          } else {
            if (_complainController.isDetailLoading.isTrue) {
              return Center(
                child: SpinKitFadingFour(
                  color: Colors.blue.shade900,
                  size: 50.0,
                ),
              );
            } else {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _complainController
                              .detailComplainFormData!.formDetail.courseName,
                          style: TextStyle(
                              fontSize: textScale >= 1.3
                                  ? 15.0.sp / textScale * 1.3
                                  : 16.0.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  size: 22.0,
                                  color: Colors.blue.shade900,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  formatDate(_complainController
                                      .detailComplainFormData!
                                      .formDetail
                                      .startTime
                                      .toString()
                                      .substring(0, 10)),
                                  style: TextStyle(
                                      fontSize: textScale >= 1.3
                                          ? 12.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 22.0,
                                  color: Colors.blue.shade900,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  _complainController
                                      .detailComplainFormData!.formDetail.room,
                                  style: TextStyle(
                                      fontSize: textScale >= 1.3
                                          ? 12.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_rounded,
                              size: 22.0,
                              color: Colors.blue.shade900,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${formatDateTime(_complainController.detailComplainFormData!.formDetail.startTime).substring(0, 8)} - ${formatDateTime(_complainController.detailComplainFormData!.formDetail.endTime).substring(0, 8)}",
                              style: TextStyle(
                                  fontSize: textScale >= 1.3
                                      ? 12.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Thời gian điểm danh: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black)),
                            Flexible(
                                child: Text(
                                    _complainController.detailComplainFormData!
                                                .formDetail.checkinTime ==
                                            null
                                        ? ""
                                        : formatDateTime(_complainController
                                                .detailComplainFormData!
                                                .formDetail
                                                .checkinTime)
                                            .substring(0, 8),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: textScale >= 1.3
                                          ? 11.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      color: Colors.black,
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Trạng thái hiện tại: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: textScale >= 1.3
                                        ? 13.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black)),
                            Text(
                                _complainController.detailComplainFormData!
                                    .formDetail.currentStatus,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: textScale >= 1.3
                                        ? 13.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Thay đổi thành: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textScale >= 1.3
                                      ? 13.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                )),
                            Text(
                                _complainController.detailComplainFormData!
                                    .formDetail.requestStatus
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: textScale >= 1.3
                                        ? 13.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Gửi đến: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textScale >= 1.3
                                      ? 12.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                )),
                            Text(
                              _complainController.detailComplainFormData!
                                  .formDetail.teacherName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: textScale >= 1.3
                                      ? 12.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Nội dung phản ánh:',
                                style: TextStyle(
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            '- ${_complainController.detailComplainFormData!.formDetail.reason}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: textScale >= 1.3
                                  ? 12.0.sp / textScale * 1.3
                                  : 13.0.sp,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        _complainController.detailComplainFormData!.formDetail
                                    .rejectReason ==
                                ""
                            ? const SizedBox.shrink()
                            : Text('Lí do từ chối',
                                style: TextStyle(
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                        _complainController.detailComplainFormData!.formDetail
                                    .rejectReason ==
                                ""
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 10,
                              ),
                        _complainController.detailComplainFormData!.formDetail
                                    .rejectReason ==
                                ""
                            ? const SizedBox.shrink()
                            : Text(
                                '- ${_complainController.detailComplainFormData!.formDetail.rejectReason}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: textScale >= 1.3
                                      ? 12.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                )),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title:
                                      'Bạn chắc chắn muốn hủy phản ánh đã tạo?',
                                  titleStyle: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 14.0.sp / textScale * 1.4
                                          : 14.0.sp,
                                      fontWeight: FontWeight.w700),
                                  middleText:
                                      'Đơn phản ánh sẽ bị hủy sau khi bạn chọn “Hủy” phản ánh này.',
                                  middleTextStyle: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 13.0.sp / textScale * 1.4
                                          : 13.0.sp,
                                      fontWeight: FontWeight.w500),
                                  backgroundColor: Colors.white,
                                  radius: 10.0,
                                  confirm: ElevatedButton(
                                      onPressed: () {
                                        _complainController.deleteComplainForm(
                                            _complainController
                                                .selectedFormId.value);
                                        Get.back();
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
                                        primary: Colors.red,
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
                            child: Text(
                              'Hủy'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: textScale >= 1.3
                                      ? 13.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              minimumSize: const Size.fromHeight(40),
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0.sp),
                              ),
                            ))
                      ],
                    ),
                  )));
            }
          }
        })));
  }

  String formatDate(date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String formatDateTime(String date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a, dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  //validate email function
  String? validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nội dung phản ánh không được để trống!';
    } else {
      return null;
    }
  }
}
