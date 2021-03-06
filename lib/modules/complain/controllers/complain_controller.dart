import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/complain/models/complain_form_response_model.dart';
import 'package:smartschool_mobile/modules/complain/models/detail_complain_form_response.dart';
import 'package:smartschool_mobile/modules/complain/models/request_complain_request_model.dart';
import 'package:smartschool_mobile/modules/complain/providers/complain_provider.dart';
import 'package:smartschool_mobile/modules/report/providers/report_provider.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class ComplainController extends GetxController {
  var hasInternet = false.obs;

  var isLoading = false.obs;

  var isRequestLoading = false.obs;

  var isDetailLoading = false.obs;

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

  var userSemestersList = [].obs;

  var currentSemesterValue = "".obs;

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
      getComplainList(int.parse(currentSemesterValue.value));
      isLoading(false);
    } else {
      isLoading(false);
    }
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
    isDetailLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res =
        await ComplainProvider().getDetailComplainForm(headers, selectedForm);

    if (res != null) {
      _detailComplainFormData = res;
      isDetailLoading(false);
    } else {
      _detailComplainFormData = null;
      isDetailLoading(false);
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
      Get.snackbar('L????i ', "Ba??n ch??a k????t n????i internet!",
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
        Get.snackbar('Tha??nh c??ng', 'Hu??y pha??n a??nh tha??nh c??ng!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading(false);
        Get.back();

        Get.snackbar('Th????t ba??i', 'Hu??y pha??n a??nh th????t ba??i!',
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
      filterComplainList.value = complainList.reversed.toList();
      isLoading(false);
    } else {
      complainList.value = [];
      isLoading(false);
    }
  }

  void filterComplainListFun(int filterValue) {
    if (filterValue == 0) {
      filterComplainList.value = complainList.reversed.toList();
    } else if (filterValue == 1) {
      filterComplainList.value = complainList.reversed
          .toList()
          .where(
              (complainItem) => complainItem["form_status"] == "??ang ch??? duy???t")
          .toList();
    } else {
      filterComplainList.value = complainList.reversed
          .toList()
          .where((complainItem) =>
              complainItem["form_status"] == "Ch???p nh???n" ||
              complainItem["form_status"] == "T???? ch????i")
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

    if (hasInternet.isFalse) {
      Get.snackbar('L????i ', "Ba??n ch??a k????t n????i internet!",
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
            title: Text('Tha??nh c??ng!',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800)),
            content: Text('Pha??n a??nh cu??a ba??n ??ang ????????c xe??t duy????t!',
                style:
                    TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w500)),
            actions: [
              TextButton(
                child: Text("??o??ng",
                    style: TextStyle(
                        fontSize: 12.0.sp, color: Colors.blue.shade900)),
                onPressed: () {
                  Get.back();
                  Get.back();
                  getUserSemestersList();
                  Get.toNamed(Routes.complainList);
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
            title: Text('Th????t ba??i!',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red)),
            content: Text('G????i pha??n a??nh th????t ba??i',
                style:
                    TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.w600)),
            actions: [
              TextButton(
                child: Text("??o??ng",
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

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }

  //clear textfield
  void clearTextField() {
    complainReasonEditingController!.clear();
  }
}
