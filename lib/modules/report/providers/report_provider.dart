import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/report/models/user_course_attendance_response_model.dart';

class ReportProvider extends GetConnect {
  final String userSemesterListUrl =
      'http://13.228.244.196:6002/user/semesters';
  final String userCoursesInSemesterListUrl =
      'http://13.228.244.196:6002/user/courses-in-semester?semester_id=';
  final String userCourseAttendaceListUrl =
      'http://13.228.244.196:6002/user/course-attendance?course_id=';

  Future<List<dynamic>> getUserSemestersList(headers) async {
    final response = await get(userSemesterListUrl, headers: headers);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body['semester_list'];
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

  Future<UserCourseAttendanceResponeModel?> getUserCourseAttendace(
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
