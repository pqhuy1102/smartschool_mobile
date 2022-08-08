import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/late/controllers/late_controller.dart';

class DetailLateFormScreen extends StatefulWidget {
  const DetailLateFormScreen({Key? key}) : super(key: key);

  @override
  State<DetailLateFormScreen> createState() => _DetailLateFormScreenState();
}

class _DetailLateFormScreenState extends State<DetailLateFormScreen> {
  final LateController _lateController = Get.put(LateController());

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
            'Chi tiết xin phép',
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
          if (_lateController.hasInternet.isFalse) {
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
            if (_lateController.isDetailLoading.isTrue) {
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
                          _lateController
                              .detailLateFormData!.formDetail.courseName,
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
                                  formatDate(_lateController
                                      .detailLateFormData!.formDetail.startTime
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
                                  _lateController
                                      .detailLateFormData!.formDetail.room,
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
                              "${formatDateTime(_lateController.detailLateFormData!.formDetail.startTime).substring(0, 8)} - ${formatDateTime(_lateController.detailLateFormData!.formDetail.endTime).substring(0, 8)}",
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
                            Text('Đăng ký: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textScale >= 1.3
                                      ? 13.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                )),
                            Text(
                                _lateController.detailLateFormData!.formDetail
                                    .requestStatus
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
                            Flexible(
                                child: Text(
                              _lateController
                                  .detailLateFormData!.formDetail.teacherName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: textScale >= 1.3
                                      ? 12.0.sp / textScale * 1.3
                                      : 13.0.sp,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Lý do:',
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
                            '- ${_lateController.detailLateFormData!.formDetail.reason}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: textScale >= 1.3
                                  ? 12.0.sp / textScale * 1.3
                                  : 13.0.sp,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        _lateController.detailLateFormData!.formDetail
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
                        _lateController.detailLateFormData!.formDetail
                                    .rejectReason ==
                                ""
                            ? const SizedBox.shrink()
                            : const SizedBox(
                                height: 10,
                              ),
                        _lateController.detailLateFormData!.formDetail
                                    .rejectReason ==
                                ""
                            ? const SizedBox.shrink()
                            : Text(
                                '- ${_lateController.detailLateFormData!.formDetail.rejectReason}',
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
                                      'Bạn chắc chắn muốn hủy đơn xin phép đã tạo?',
                                  titleStyle: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 14.0.sp / textScale * 1.4
                                          : 14.0.sp,
                                      fontWeight: FontWeight.w700),
                                  middleText:
                                      'Đơn xin phép sẽ bị hủy sau khi bạn chọn “Hủy” đơn xin phép này.',
                                  middleTextStyle: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 13.0.sp / textScale * 1.4
                                          : 13.0.sp,
                                      fontWeight: FontWeight.w500),
                                  backgroundColor: Colors.white,
                                  radius: 10.0,
                                  confirm: ElevatedButton(
                                      onPressed: () {
                                        _lateController.deleteLateForm(
                                            _lateController
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
