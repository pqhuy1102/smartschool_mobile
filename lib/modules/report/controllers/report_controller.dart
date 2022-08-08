import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/widgets/onboard.dart';
import 'package:smartschool_mobile/modules/complain/controllers/complain_controller.dart';
import 'package:smartschool_mobile/modules/report/providers/report_provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ReportController extends GetxController {
  var hasInternet = false.obs;

  var isLoading = false.obs;

  late final AuthenticationManager _authenticationManager;

  late final ComplainController _complainController;

  var userSemestersList = [].obs;

  var currentSemesterValue = "".obs;

  var userCoursesList = [].obs;

  var userCourseAttendanceList = [].obs;

  var selectedCourse = "".obs;

  var filterCourseAttendance = [].obs;

  var filterValue = "1".obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();

    _complainController = Get.put(ComplainController());

    getInternetStatus();

    getUserSemestersList();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
      if (hasInternet.isTrue) {
        getUserSemestersList();
      }
    });
  }

  Future<void> getUserSemestersList() async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider().getUserSemestersList(headers);

    if (res != null && res != 'unauthorized') {
      userSemestersList.value = res.body["semester_list"];
      currentSemesterValue.value = userSemestersList.last['id'].toString();
      getCoursesInSemester();
      _complainController
          .getComplainList(int.parse(currentSemesterValue.value));
      isLoading(false);
    } else if (res == 'unauthorized') {
      Get.dialog(
        AlertDialog(
          title: Text('Cảnh báo!',
              style: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red)),
          content: Text(
              'Phiên đăng nhập của bạn đã hết hạn, vui lòng đăng nhập lại!',
              style: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w600)),
          actions: [
            TextButton(
                child: Text("Đăng nhập lại",
                    style: TextStyle(
                        fontSize: 13.0.sp, color: Colors.blue.shade900)),
                onPressed: () {
                  _authenticationManager.logOut();
                  Get.offAll(() => const OnBoard());
                }),
          ],
        ),
      );

      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  Future<void> getCoursesInSemester() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider()
        .getUserCoursesInSemester(headers, currentSemesterValue.value);
    userCoursesList.value = res;
  }

  Future<void> getCourseAttendance(selectedCourseId) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider()
        .getUserCourseAttendance(headers, selectedCourseId);
    if (res != null) {
      isLoading(false);
      userCourseAttendanceList.value = res.attendanceList;

      filterCourseAttendance.value = res.attendanceList;
      selectedCourse.value = res.course;
      filterValue.value = "1";
    } else {
      isLoading(false);
      Get.snackbar('Lỗi ', 'Lấy danh sách thất bại!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void filterCourseAttendanceFun(String filterValue) {
    if (filterValue == "1") {
      filterCourseAttendance.value = userCourseAttendanceList;
    } else if (filterValue == "2") {
      filterCourseAttendance.value = userCourseAttendanceList
          .where(
              (courseAttendance) => courseAttendance.checkInStatus == "Attend")
          .toList();
    } else if (filterValue == "3") {
      filterCourseAttendance.value = userCourseAttendanceList
          .where((courseAttendance) => courseAttendance.checkInStatus == "Late")
          .toList();
    } else {
      filterCourseAttendance.value = userCourseAttendanceList
          .where((courseAttendance) => courseAttendance.checkInStatus == "")
          .toList();
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
