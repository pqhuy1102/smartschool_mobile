import 'package:get/get.dart';
import 'package:smartschool_mobile/constants.dart';

class GetIndayAttendanceProvider extends GetConnect {
  final String getIndayAttendanceUrl =
      '${Constant.apiDomain}/user/inday-attendance?time_offset=';

  Future<dynamic> getIndayAttendance(headers, String today) async {
    final response = await get(getIndayAttendanceUrl + today, headers: headers);

    if (response.status.isOk) {
      if (response.body['checkin_list'] == null) {
        return [];
      }
      return response.body['checkin_list'];
    } else if (response.status.isUnauthorized) {
      return 'unauthorized';
    } else {
      return null;
    }
  }
}
