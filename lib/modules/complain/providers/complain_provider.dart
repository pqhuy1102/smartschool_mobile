import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/complain/models/complain_form_response_model.dart';
import 'package:smartschool_mobile/modules/complain/models/request_complain_request_model.dart';

class ComplainProvider extends GetConnect {
  final String getComplainFormUrl =
      '${Constant.apiDomain}/user/get-form-request-change-attendance-status?schedule_id=';
  final String requestComplainUrl =
      '${Constant.apiDomain}/user/request-change-attendance-status';

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
}
