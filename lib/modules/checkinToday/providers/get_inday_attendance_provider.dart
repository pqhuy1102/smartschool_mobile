import 'package:get/get.dart';

class GetIndayAttendanceProvider extends GetConnect {
  final String getIndayAttendanceUrl =
      'http://13.228.244.196:6002/user/inday-attendance?time_offset=7';

  Future<List<dynamic>> getIndayAttendance(headers) async {
    final response = await get(getIndayAttendanceUrl, headers: headers);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body['checkin_list'];
    }
  }
}
