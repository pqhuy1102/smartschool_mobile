import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/report/models/user_course_attendance_response_model.dart';

class ReportProvider extends GetConnect {
  final String userSemesterListUrl = '${Constant.apiDomain}/user/semesters';
  final String userCoursesInSemesterListUrl =
      '${Constant.apiDomain}/user/courses-in-semester?semester_id=';
  final String userCourseAttendaceListUrl =
      '${Constant.apiDomain}/user/course-attendance?course_id=';

  Future<dynamic> getUserSemestersList(headers) async {
    final response = await get(userSemesterListUrl, headers: headers);
    if (response.status.isOk) {
      return response;
    } else if (response.status.isUnauthorized) {
      return 'unauthorized';
    } else {
      return null;
    }
  }

  Future<List<dynamic>> getUserCoursesInSemester(
      headers, String selectedSemesterId) async {
    final String url = userCoursesInSemesterListUrl + selectedSemesterId;
    final response = await get(url, headers: headers);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body['course_list'];
    }
  }

  Future<UserCourseAttendanceResponeModel?> getUserCourseAttendance(
      headers, String selectedCourseId) async {
    final String url = userCourseAttendaceListUrl + selectedCourseId;
    final response = await get(url, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return UserCourseAttendanceResponeModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
