import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/complain/models/complain_form_response_model.dart';
import 'package:smartschool_mobile/modules/complain/models/detail_complain_form_response.dart';
import 'package:smartschool_mobile/modules/complain/models/request_complain_request_model.dart';

class LateProvider extends GetConnect {
  final String getComplainFormUrl =
      '${Constant.apiDomain}/user/get-form-request-change-attendance-status?schedule_id=';
  final String requestComplainUrl =
      '${Constant.apiDomain}/user/request-change-attendance-status';
  final String getLateFormListUrl =
      '${Constant.apiDomain}/user/get-absence-form-request?semester_id=';
  final String deleteComplainFormUrl =
      '${Constant.apiDomain}/user/delete-complain-form?form_id=';
  final String getDetailComplainFormUrl =
      '${Constant.apiDomain}/user/get-form-request-detail?form_id=';
  final String getIndayScheduleUrl =
      '${Constant.apiDomain}/user/inday-schedule?time_offset=';

  Future<ComplainFormResponeModel?> getComplainForm(
      headers, int selectedSchedule) async {
    final response = await get(getComplainFormUrl + selectedSchedule.toString(),
        headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return complainFormResponeModelFromJson(response.bodyString!);
    } else {
      return null;
    }
  }

  Future<DetailComplainFormResponseModel?> getDetailComplainForm(
      headers, int selectedForm) async {
    final response = await get(
        getDetailComplainFormUrl + selectedForm.toString(),
        headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return detailComplainFormResponseModelFromJson(response.bodyString!);
    } else {
      return null;
    }
  }

  Future<dynamic> deleteComplainForm(headers, int selectedForm) async {
    final response = await get(deleteComplainFormUrl + selectedForm.toString(),
        headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return response;
    } else {
      return null;
    }
  }

  Future<dynamic> requestComplain(
      RequestComplainRequestModel model, headers) async {
    final response =
        await post(requestComplainUrl, model.toJson(), headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> getLateFormList(headers, int selectedSemester) async {
    final response = await get(getLateFormListUrl + selectedSemester.toString(),
        headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return response.body["form_list"];
    } else {
      return null;
    }
  }

  Future getIndaySchedule(headers, String today) async {
    final response = await get(getIndayScheduleUrl + today, headers: headers);
    if (response.status.hasError) {
      return null;
    } else {
      if (response.body['checkin_list'] == null) {
        return [];
      }
      return response.body['checkin_list'];
    }
  }
}
