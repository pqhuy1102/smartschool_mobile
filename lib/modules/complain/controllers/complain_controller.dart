import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/complain/models/complain_form_response_model.dart';
import 'package:smartschool_mobile/modules/complain/models/detail_complain_form_response.dart';
import 'package:smartschool_mobile/modules/complain/models/request_complain_request_model.dart';
import 'package:smartschool_mobile/modules/complain/providers/complain_provider.dart';

class ComplainController extends GetxController {
  var hasInternet = false.obs;

  var isLoading = false.obs;

  var isRequestLoading = false.obs;

  final scheduleId = 0.obs;

  // ignore: prefer_typing_uninitialized_variables
  var _complainRequestData;
  // ignore: prefer_typing_uninitialized_variables
  var _detailComplainFormData;

  final defaultTeacherId = "".obs;

  final defaultRequestStatus = "".obs;

  final complainList = [].obs;

  final filterComplainList = [].obs;

  final filterValue = 0.obs;

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
  }

  ComplainFormResponeModel? get complainRequestData => _complainRequestData;
  DetailComplainFormResponseModel? get detailComplainFormData =>
      _detailComplainFormData;

  Future<void> getComplainForm(int scheduleId) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ComplainProvider().getComplainForm(headers, scheduleId);

    if (res != null) {
      _complainRequestData = res;
      defaultTeacherId.value = res.teacherList.first.id.toString();
      defaultRequestStatus.value = res.requestStatus.first.toString();
      isLoading(false);
    } else {
      _complainRequestData = null;
      isLoading(false);
    }
  }

  Future<void> getDetailComplainForm(int selectedForm) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res =
        await ComplainProvider().getDetailComplainForm(headers, selectedForm);

    if (res != null) {
      _detailComplainFormData = res;
      print(_detailComplainFormData.formDetail.currentStatus);
      isLoading(false);
    } else {
      _detailComplainFormData = null;
      isLoading(false);
    }
  }

  Future<void> deleteComplainForm(int selectedForm) async {
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
        filterComplainList
            .removeWhere((item) => item["form_id"] == selectedForm);
        complainList.removeWhere((item) => item["form_id"] == selectedForm);
        isLoading(false);
        Get.back();
        Get.snackbar('Thành công', 'Hủy phản ánh thành công!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading(false);

        Get.snackbar('Thất bại', 'Hủy phản ánh thất bại!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  Future<void> getComplainList(int selectedSemester) async {
    isLoading(true);
    filterValue.value = 0;
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res =
        await ComplainProvider().getComplainList(headers, selectedSemester);

    if (res != null) {
      complainList.value = res;
      filterComplainList.value = res;
      isLoading(false);
    } else {
      complainList.value = [];
      isLoading(false);
    }
  }

  void filterComplainListFun(int filterValue) {
    if (filterValue == 0) {
      filterComplainList.value = complainList;
    } else if (filterValue == 1) {
      filterComplainList.value = complainList
          .where(
              (complainItem) => complainItem["form_status"] == "Đang chờ duyệt")
          .toList();
    } else {
      filterComplainList.value = complainList
          .where((complainItem) =>
              complainItem["form_status"] == "Chấp nhận" ||
              complainItem["form_status"] == "Từ chối")
          .toList();
    }
  }

  Future<void> requestComplain() async {
    isRequestLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ComplainProvider().requestComplain(
        RequestComplainRequestModel(
          scheduleId: _complainRequestData.scheduleId,
          requestCheckinStatus: defaultRequestStatus.value,
          reason: complainReasonEditingController!.text.trim(),
          toUserId: int.parse(defaultTeacherId.value),
        ),
        headers);
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
          content: Text('Phản ánh của bạn đang được xét duyệt',
              style: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w500)),
          actions: [
            TextButton(
              child: Text("Đóng",
                  style: TextStyle(
                      fontSize: 12.0.sp, color: Colors.blue.shade900)),
              onPressed: () {
                Get.back();
                Get.back();
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
          content: Text('Gửi phản ánh thất bại',
              style: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w600)),
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

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  //clear textfield
  void clearTextField() {
    complainReasonEditingController!.clear();
  }
}
