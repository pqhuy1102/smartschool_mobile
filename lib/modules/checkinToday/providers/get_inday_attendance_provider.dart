import 'package:get/get.dart';
import 'package:smartschool_mobile/constants.dart';

class GetIndayAttendanceProvider extends GetConnect {
  final String getIndayAttendanceUrl =
      '${Constant.apiDomain}/user/inday-attendance?time_offset=7';

  Future<List<dynamic>> getIndayAttendance(headers) async {
    final response = await get(getIndayAttendanceUrl, headers: headers);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      if (response.body['checkin_list'] == null) {
        return [];
      }
      return response.body['checkin_list'];
    }
  }
}
