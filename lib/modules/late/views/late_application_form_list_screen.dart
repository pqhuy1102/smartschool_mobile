import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/late/controllers/late_controller.dart';
// ignore: library_prefixes
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:smartschool_mobile/modules/late/widgets/late_application_item.dart';
import 'package:smartschool_mobile/routes/routes.dart';

class LateApplicationFormListScreen extends StatefulWidget {
  const LateApplicationFormListScreen({Key? key}) : super(key: key);

  @override
  State<LateApplicationFormListScreen> createState() =>
      _LateApplicationFormListScreenState();
}

class _LateApplicationFormListScreenState
    extends State<LateApplicationFormListScreen> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final LateController _lateController = Get.put(LateController());

    return Scaffold(
        extendBodyBehindAppBar: true,
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
            'Nghỉ phép/ Đi trễ',
            style: TextStyle(
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: SizedBox(
            height: 60.0,
            width: 60.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.lateApplicationFormList +
                      Routes.chooseDateForLate);
                },
                backgroundColor: Colors.blue.shade900.withOpacity(1),
                child: const Icon(
                  Icons.add,
                  size: 30.0,
                ),
              ),
            )),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(child: Obx(() {
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
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              color: Colors.grey.shade600,
                              size: 13.0.sp,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                "Học kỳ",
                                style: TextStyle(
                                    fontSize: (textScale > 1.4
                                        ? 13.0.sp / textScale * 1.4
                                        : 13.0.sp),
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Obx(() {
                          return SizedBox(
                              width: textScale >= 1.2 ? 60.0.w : 50.0.w,
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
                                      .currentSemesterValue.value,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  iconSize: 26,
                                  buttonHeight: shortestSide < 600 ? 28 : 50,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: _lateController.userSemestersList
                                      .map((sem) {
                                    return DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          "${sem['title']} ${sem['year']}",
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 12.0.sp / textScale * 1.3
                                                  : 12.0.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: sem['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _lateController.currentSemesterValue.value =
                                        value.toString();
                                    _lateController.getLateFormList(int.parse(
                                        _lateController
                                            .currentSemesterValue.value));
                                  },
                                ),
                              ));
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: CupertinoTabBar.CupertinoTabBar(
                      Colors.blue.shade900,
                      Colors.white,
                      [
                        Text(
                          "Tất cả",
                          style: TextStyle(
                            color: _lateController.filterValue.value == 0
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Chưa duyệt",
                          style: TextStyle(
                            color: _lateController.filterValue.value == 1
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Đã duyệt",
                          style: TextStyle(
                            color: _lateController.filterValue.value == 2
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      _lateController.filterValueGetter,
                      (index) {
                        _lateController.filterValue.value = index;
                        _lateController.filterLateFormListFun(index);
                      },
                      useSeparators: true,
                      innerHorizontalPadding: 20.0,
                      innerVerticalPadding: 12.0,
                      fittedWhenScrollable: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (_lateController.isLoading.isTrue) {
                      return Center(
                        child: SpinKitFadingFour(
                          color: Colors.blue.shade900,
                          size: 35.0.sp,
                        ),
                      );
                    } else if (_lateController.filterLateFormList.isEmpty) {
                      return Column(
                        children: [
                          Image.asset(
                            'assets/images/no_data.gif',
                          ),
                          Center(
                              child: Text(
                            'Danh sách trống! ',
                            style: TextStyle(
                                fontSize: textScale > 1.4
                                    ? 13.0.sp / textScale * 1.3
                                    : 13.0.sp,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                              itemCount:
                                  _lateController.filterLateFormList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: LateApplicationItem(
                                      formId: _lateController
                                          .filterLateFormList[index]["form_id"],
                                      courseName: _lateController
                                                  .filterLateFormList[index]
                                              ["course_name"] ??
                                          "",
                                      createTime: formatDateTime(_lateController
                                          .filterLateFormList[index]
                                              ["created_time"]
                                          .toString()
                                          .substring(0, 18)),
                                      currentStatus:
                                          _lateController.filterLateFormList[index]
                                                  ["current_status"] ??
                                              "",
                                      formStatus: _lateController.filterLateFormList[index]["form_status"] ?? "",
                                      requestStatus: _lateController.filterLateFormList[index]["request_status"] ?? "",
                                      teacherName: _lateController.filterLateFormList[index]["teacher_name"] ?? ""),
                                  onTap: () {
                                    _lateController.getDetailLateForm(
                                        _lateController
                                                .filterLateFormList[index]
                                            ["form_id"]);

                                    Get.toNamed(Routes.lateApplicationFormList +
                                        Routes.detailLateForm);
                                  },
                                );
                              }));
                    }
                  })
                ],
              );
            }
          })),
        ));
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
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a, dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
