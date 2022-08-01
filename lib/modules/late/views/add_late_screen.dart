import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/late/controllers/late_controller.dart';

class AddLateScreen extends StatefulWidget {
  const AddLateScreen({Key? key}) : super(key: key);

  @override
  State<AddLateScreen> createState() => _AddLateScreenState();
}

class _AddLateScreenState extends State<AddLateScreen> {
  final LateController _lateController = Get.put(LateController());

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
            'Thêm nghỉ phép/ đi trễ',
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
            if (_lateController.isLoading.isTrue) {
              return Center(
                child: SpinKitFadingFour(
                  color: Colors.blue.shade900,
                  size: 50.0,
                ),
              );
            } else {
              if (_lateController.complainRequestData == null) {
                return Center(
                  child: Text(
                    'Bạn không thể thêm đăng ký mới cho ca học này!',
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
                            _lateController.complainRequestData!.courseName,
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
                                    size: 22.0,
                                    color: Colors.blue.shade900,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    _lateController.complainRequestData!.room,
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
                                "${formatDateTime(_lateController.complainRequestData!.startTime).substring(0, 8)} - ${formatDateTime(_lateController.complainRequestData!.endTime).substring(0, 8)}",
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Đăng ký: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: textScale > 1.2 ? 70.0.w : 60.0.w,
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
                                        value: _lateController
                                            .defaultRequestStatus.value,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 26,
                                        buttonHeight:
                                            shortestSide > 600 ? 52 : 27,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 10, right: 5),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        items: _lateController
                                            .complainRequestData?.requestStatus
                                            .map((status) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              status,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: textScale >= 1.3
                                                      ? 11.0.sp /
                                                          textScale *
                                                          1.3
                                                      : 11.0.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: status.toString(),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          _lateController.defaultRequestStatus
                                              .value = value.toString();
                                        }),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gửi đến: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: textScale >= 1.3
                                        ? 12.0.sp / textScale * 1.3
                                        : 13.0.sp,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: textScale > 1.2 ? 70.0.w : 60.0.w,
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
                                      value: _lateController
                                          .defaultTeacherId.value,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 26,
                                      buttonHeight:
                                          shortestSide < 600 ? 30 : 50,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: _lateController
                                          .complainRequestData?.teacherList
                                          .map((teacher) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            teacher.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: textScale >= 1.3
                                                    ? 11.0.sp / textScale * 1.2
                                                    : 11.0.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          value: teacher.id.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _lateController.defaultTeacherId.value =
                                            value.toString();
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
                              Text('Lý do:',
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
                              controller: _lateController
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
                                    _lateController.isRequestLoading.isFalse) {
                                  _lateController.requestLate();
                                } else {
                                  setState(() {
                                    _autovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });
                                }
                              },
                              child: Obx(() {
                                if (_lateController.isRequestLoading.isTrue) {
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

  String formatDateTime(String? date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date!, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a, dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  //validate email function
  String? validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lý do không được để trống!';
    } else {
      return null;
    }
  }
}
