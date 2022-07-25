import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/complain/controllers/complain_controller.dart';

class AddComplainScreen extends StatefulWidget {
  const AddComplainScreen({Key? key}) : super(key: key);

  @override
  State<AddComplainScreen> createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  final ComplainController _complainController = Get.put(ComplainController());

  final _formKey = GlobalKey<FormState>();

  late AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

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
            'Thêm phản ánh',
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
            if (_complainController.isLoading.isTrue) {
              return Center(
                child: SpinKitFadingFour(
                  color: Colors.blue.shade900,
                  size: 50.0,
                ),
              );
            } else {
              if (_complainController.complainRequestData == null) {
                return Center(
                  child: Text(
                    'Bạn không thể thêm phản ánh mới cho ca học này!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textScale > 1.4
                            ? 14.0.sp / textScale * 1.4
                            : 14.0.sp,
                        fontWeight: FontWeight.w600),
                  ),
                );
              } else {
                return Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SingleChildScrollView(
                        child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _complainController.complainRequestData!.courseName,
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
                                    size: 24.0,
                                    color: Colors.blue.shade900,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    formatDate(_complainController
                                        .complainRequestData!.startTime
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
                                    size: 24.0,
                                    color: Colors.blue.shade900,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    _complainController
                                        .complainRequestData!.room,
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
                                size: 24.0,
                                color: Colors.blue.shade900,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${formatDateTime(_complainController.complainRequestData!.startTime).substring(0, 8)} - ${formatDateTime(_complainController.complainRequestData!.endTime).substring(0, 8)}",
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
                                      _complainController.complainRequestData
                                              ?.checkInTime ??
                                          "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: textScale >= 1.3
                                            ? 11.0.sp / textScale * 1.3
                                            : 12.0.sp,
                                        color: Colors.grey.shade600,
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
                                          ? 12.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      color: Colors.black)),
                              Text(
                                  _complainController
                                      .complainRequestData!.currentCheckInStatus
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: textScale >= 1.3
                                          ? 12.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      color: _complainController
                                                  .complainRequestData!
                                                  .currentCheckInStatus ==
                                              "Vắng"
                                          ? Colors.red
                                          : _complainController
                                                      .complainRequestData!
                                                      .currentCheckInStatus ==
                                                  "Hợp lệ"
                                              ? Colors.green.shade800
                                              : Colors.orange.shade600))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thay đổi thành: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                  )),
                              SizedBox(
                                  width: textScale > 1.2 ? 33.0.w : 30.0.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueGrey,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonFormField2(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        isExpanded: true,
                                        value: _complainController
                                            .defaultRequestStatus.value,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 26,
                                        buttonHeight:
                                            shortestSide > 600 ? 52 : 30,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        items: _complainController
                                            .complainRequestData?.requestStatus
                                            .map((status) {
                                          return DropdownMenuItem(
                                            child: Center(
                                              child: Text(
                                                status,
                                                style: TextStyle(
                                                    color: status.trim() ==
                                                            "Hợp lệ"
                                                        ? Colors.green.shade800
                                                        : status.trim() ==
                                                                "Đi trễ"
                                                            ? Colors
                                                                .orange.shade600
                                                            : Colors.red,
                                                    fontSize: textScale >= 1.3
                                                        ? 11.0.sp /
                                                            textScale *
                                                            1.3
                                                        : 13.0.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            value: status.toString(),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          _complainController
                                              .defaultRequestStatus
                                              .value = value.toString();
                                        }),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Gửi đến: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                  )),
                              SizedBox(
                                  width: textScale >= 1.2 ? 60.0.w : 58.0.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueGrey,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonFormField2(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                      isExpanded: true,
                                      value: _complainController
                                          .defaultTeacherId.value,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 26,
                                      buttonHeight:
                                          shortestSide < 600 ? 32 : 50,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 12, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: _complainController
                                          .complainRequestData?.teacherList
                                          .map((teacher) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            teacher.name,
                                            style: TextStyle(
                                                fontSize: textScale >= 1.3
                                                    ? 11.0.sp / textScale * 1.2
                                                    : 12.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          value: teacher.id.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _complainController.defaultTeacherId
                                            .value = value.toString();
                                      },
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Nội dung phản ánh',
                                  style: TextStyle(
                                      fontSize: textScale >= 1.3
                                          ? 12.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('*',
                                  style: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 13.0.sp / textScale * 1.3
                                          : 13.0.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _formKey,
                            autovalidateMode: _autovalidateMode,
                            child: TextFormField(
                              validator: (value) => validateReason(value),
                              controller: _complainController
                                  .complainReasonEditingController,
                              style: TextStyle(
                                fontSize: textScale > 1.4
                                    ? 12.0.sp / textScale * 1.3
                                    : 13.0.sp,
                              ),
                              maxLines: null,
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: textScale > 1.4
                                        ? 12.0.sp / textScale * 1.3
                                        : 12.0.sp,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900)),
                                  hintText: 'Nêu nội dung phản ánh',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    _complainController
                                        .isRequestLoading.isFalse) {
                                  _complainController.requestComplain();
                                } else {
                                  setState(() {
                                    _autovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });
                                }
                              },
                              child: Obx(() {
                                if (_complainController
                                    .isRequestLoading.isTrue) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        'Đang gửi yêu cầu...',
                                        style: TextStyle(
                                            fontSize: textScale > 1.4
                                                ? 14.0.sp / textScale * 1.4
                                                : 14.0.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  );
                                } else {
                                  return Text(
                                    'hoàn tất'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: textScale >= 1.3
                                            ? 13.0.sp / textScale * 1.3
                                            : 13.0.sp,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              }),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                minimumSize: const Size.fromHeight(40),
                                primary: Colors.blue.shade900,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0.sp),
                                ),
                              ))
                        ],
                      ),
                    )));
              }
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
