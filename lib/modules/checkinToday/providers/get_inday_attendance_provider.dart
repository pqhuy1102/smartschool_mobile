import 'package:get/get.dart';
import 'package:smartschool_mobile/constants.dart';

class GetIndayAttendanceProvider extends GetConnect {
  final String getIndayAttendanceUrl =
      '${Constant.apiDomain}/user/inday-attendance?time_offset=2022-07-24';

  Future getIndayAttendance(headers) async {
    final response = await get(getIndayAttendanceUrl, headers: headers);
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
