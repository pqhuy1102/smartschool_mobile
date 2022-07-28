import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/complain/controllers/complain_controller.dart';
import 'package:smartschool_mobile/modules/complain/widgets/complain_item.dart';
import 'package:smartschool_mobile/modules/report/controllers/report_controller.dart';
// ignore: library_prefixes
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:smartschool_mobile/routes/routes.dart';

class ComplainListScreen extends StatefulWidget {
  const ComplainListScreen({Key? key}) : super(key: key);

  @override
  State<ComplainListScreen> createState() => _ComplainListScreenState();
}

class _ComplainListScreenState extends State<ComplainListScreen> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final ReportController _reportController = Get.put(ReportController());
    final ComplainController _complainController =
        Get.put(ComplainController());

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
            'Phản ánh',
            style: TextStyle(
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(child: Obx(() {
            if (_reportController.hasInternet.isFalse) {
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
                                  value: _complainController
                                      .currentSemesterValue.value,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  iconSize: 26,
                                  buttonHeight: shortestSide < 600 ? 32 : 50,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: _complainController.userSemestersList
                                      .map((sem) {
                                    return DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          "${sem['title']} ${sem['year']}",
                                          style: TextStyle(
                                              fontSize: textScale > 1.4
                                                  ? 13.0.sp / textScale * 1.4
                                                  : 13.0.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: sem['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _complainController.currentSemesterValue
                                        .value = value.toString();
                                    _complainController.getComplainList(
                                        int.parse(_complainController
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
                  CupertinoTabBar.CupertinoTabBar(
                    Colors.blue.shade900,
                    Colors.white,
                    [
                      Text(
                        "Tất cả",
                        style: TextStyle(
                          color: _complainController.filterValue.value == 0
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
                          color: _complainController.filterValue.value == 1
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
                          color: _complainController.filterValue.value == 2
                              ? Colors.black87
                              : Colors.white,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    _complainController.filterValueGetter,
                    (index) {
                      _complainController.filterValue.value = index;
                      _complainController.filterComplainListFun(index);
                    },
                    useSeparators: true,
                    innerHorizontalPadding: 20.0,
                    innerVerticalPadding: 13.0,
                    fittedWhenScrollable: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (_complainController.filterComplainList.isEmpty) {
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
                                  _complainController.filterComplainList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: ComplainItem(
                                      formId: _complainController
                                          .filterComplainList[index]["form_id"],
                                      courseName: _complainController
                                                  .filterComplainList[index]
                                              ["course_name"] ??
                                          "",
                                      createTime: formatDateTime(_complainController
                                          .filterComplainList[index]
                                              ["created_time"]
                                          .toString()
                                          .substring(0, 18)),
                                      currentStatus:
                                          _complainController.filterComplainList[index]
                                                  ["current_status"] ??
                                              "",
                                      formStatus: _complainController.filterComplainList[index]["form_status"] ?? "",
                                      requestStatus: _complainController.filterComplainList[index]["request_status"] ?? "",
                                      teacherName: _complainController.filterComplainList[index]["teacher_name"] ?? ""),
                                  onTap: () {
                                    _complainController.getDetailComplainForm(
                                        _complainController
                                                .filterComplainList[index]
                                            ["form_id"]);

                                    Get.toNamed(Routes.complainList +
                                        Routes.detailComplainForm);
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
