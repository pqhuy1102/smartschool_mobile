import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/complain/models/complain_form_response_model.dart';
import 'package:smartschool_mobile/modules/complain/models/detail_complain_form_response.dart';
import 'package:smartschool_mobile/modules/complain/models/request_complain_request_model.dart';
import 'package:smartschool_mobile/modules/complain/providers/complain_provider.dart';
import 'package:smartschool_mobile/modules/late/providers/late_provider.dart';
import 'package:smartschool_mobile/modules/report/providers/report_provider.dart';

class LateController extends GetxController {
  var hasInternet = false.obs;

  var isLoading = false.obs;

  var isRequestLoading = false.obs;

  var isDetailLoading = false.obs;

  final scheduleId = 0.obs;

  // ignore: prefer_typing_uninitialized_variables
  var _lateRequestData;
  // ignore: prefer_typing_uninitialized_variables
  var _detailLateFormData;

  final defaultTeacherId = "".obs;

  final defaultRequestStatus = "".obs;

  final lateFormList = [].obs;

  final filterLateFormList = [].obs;

  final filterValue = 0.obs;

  var userSemestersList = [].obs;

  var currentSemesterValue = "".obs;

  var indayAttendanceList = [].obs;

  filterValueGetter() => filterValue.value;

  late final AuthenticationManager _authenticationManager;

  TextEditingController? complainReasonEditingController;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();

    getInternetStatus();

    complainReasonEditingController = TextEditingController();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
      if (hasInternet.isTrue) {}
    });

    getUserSemestersList();
  }

  Future<void> getUserSemestersList() async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider().getUserSemestersList(headers);

    if (res != null) {
      userSemestersList.value = res.body["semester_list"];
      currentSemesterValue.value = userSemestersList.last['id'].toString();
      getLateFormList(int.parse(currentSemesterValue.value));
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  ComplainFormResponeModel? get complainRequestData => _lateRequestData;
  DetailComplainFormResponseModel? get detailLateFormData =>
      _detailLateFormData;

  Future<void> getLateForm(int scheduleId) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ComplainProvider().getComplainForm(headers, scheduleId);

    if (res != null) {
      _lateRequestData = res;
      defaultTeacherId.value = res.teacherList.first.id.toString();
      defaultRequestStatus.value = res.requestStatus.first.toString();
      isLoading(false);
    } else {
      _lateRequestData = null;
      isLoading(false);
    }
  }

  Future<void> getDetailLateForm(int selectedForm) async {
    isDetailLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res =
        await ComplainProvider().getDetailComplainForm(headers, selectedForm);
    if (res != null) {
      _detailLateFormData = res;
      isDetailLoading(false);
    } else {
      _detailLateFormData = null;
      isDetailLoading(false);
    }
  }

  Future<void> deleteLateForm(int selectedForm) async {
    isLoading(true);

    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res =
        await ComplainProvider().deleteComplainForm(headers, selectedForm);

    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', "Bạn chưa kết nối internet!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (res != null) {
        filterLateFormList
            .removeWhere((item) => item["form_id"] == selectedForm);
        lateFormList.removeWhere((item) => item["form_id"] == selectedForm);
        isLoading(false);
        Get.back();
        Get.snackbar('Thành công', 'Hủy đơn xin phép thành công!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading(false);
        Get.back();

        Get.snackbar('Thất bại', 'Hủy đơn xin phép thất bại!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  Future<void> getLateFormList(int selectedSemester) async {
    isLoading(true);
    filterValue.value = 0;
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await LateProvider().getLateFormList(headers, selectedSemester);

    if (res != null) {
      lateFormList.value = res;
      filterLateFormList.value = lateFormList.reversed.toList();
      isLoading(false);
    } else {
      lateFormList.value = [];
      isLoading(false);
    }
  }

  void filterLateFormListFun(int filterValue) {
    if (filterValue == 0) {
      filterLateFormList.value = lateFormList.reversed.toList();
    } else if (filterValue == 1) {
      filterLateFormList.value = lateFormList.reversed
          .toList()
          .where(
              (complainItem) => complainItem["form_status"] == "Đang chờ duyệt")
          .toList();
    } else {
      filterLateFormList.value = lateFormList.reversed
          .toList()
          .where((complainItem) =>
              complainItem["form_status"] == "Chấp nhận" ||
              complainItem["form_status"] == "Từ chối")
          .toList();
    }
  }

  Future<void> requestLate() async {
    isRequestLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ComplainProvider().requestComplain(
        RequestComplainRequestModel(
          scheduleId: _lateRequestData.scheduleId,
          requestCheckinStatus: defaultRequestStatus.value,
          reason: complainReasonEditingController!.text.trim(),
          toUserId: int.parse(defaultTeacherId.value),
        ),
        headers);

    if (hasInternet.isFalse) {
      Get.snackbar('Lỗi ', "Bạn chưa kết nối internet!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      isLoading(false);
    } else {
      if (res != null) {
        isRequestLoading(false);
        clearTextField();
        Get.dialog(
          AlertDialog(
            title: Text('Thành công!',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800)),
            content: Text('Đơn xin phép của bạn đang được xét duyệt!',
                style:
                    TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w500)),
            actions: [
              TextButton(
                child: Text("Đóng",
                    style: TextStyle(
                        fontSize: 12.0.sp, color: Colors.blue.shade900)),
                onPressed: () {
                  Get.back();
                  Get.back();
                  Get.back();
                  getUserSemestersList();
                },
              ),
            ],
          ),
        );
      } else {
        isRequestLoading(false);
        clearTextField();
        Get.dialog(
          AlertDialog(
            title: Text('Thất bại!',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red)),
            content: Text('Gửi xin phép thất bại!',
                style:
                    TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w600)),
            actions: [
              TextButton(
                child: Text("Đóng",
                    style: TextStyle(
                        fontSize: 12.0.sp, color: Colors.blue.shade900)),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> getIndayAttendance(date) async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    isRequestLoading(true);

    var res = await LateProvider().getIndaySchedule(headers, date);
    if (res != null) {
      isRequestLoading(false);
      indayAttendanceList.value = res;
    } else {
      indayAttendanceList.value = [];
      isRequestLoading(false);
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  //clear textfield
  void clearTextField() {
    complainReasonEditingController!.clear();
  }
}
