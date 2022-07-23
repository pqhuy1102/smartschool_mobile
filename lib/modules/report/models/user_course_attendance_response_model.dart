// To parse this JSON data, do
//
//     final userCourseAttendanceResponeModel = userCourseAttendanceResponeModelFromJson(jsonString);

import 'dart:convert';

UserCourseAttendanceResponeModel userCourseAttendanceResponeModelFromJson(
        String str) =>
    UserCourseAttendanceResponeModel.fromJson(json.decode(str));

String userCourseAttendanceResponeModelToJson(
        UserCourseAttendanceResponeModel data) =>
    json.encode(data.toJson());

class UserCourseAttendanceResponeModel {
  UserCourseAttendanceResponeModel({
    required this.attendanceList,
    required this.course,
  });

  List<AttendanceList> attendanceList;
  String course;

  factory UserCourseAttendanceResponeModel.fromJson(
          Map<String, dynamic> json) =>
      UserCourseAttendanceResponeModel(
        attendanceList: json["attendance_list"] != null
            ? List<AttendanceList>.from(
                json["attendance_list"].map((x) => AttendanceList.fromJson(x)))
            : <AttendanceList>[],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_list":
            List<dynamic>.from(attendanceList.map((x) => x.toJson())),
        "course": course,
      };
}

class AttendanceList {
  AttendanceList(
      {required this.startTime,
      required this.endTime,
      required this.checkInTime,
      required this.room,
      required this.checkInStatus,
      required this.scheduleId});

  String startTime;
  String endTime;
  String? checkInTime;
  String room;
  String checkInStatus;
  int scheduleId;

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
      startTime: json["start_time"],
      endTime: json["end_time"],
      checkInTime: json["check_in_time"],
      room: json["room"],
      checkInStatus: json["check_in_status"],
      scheduleId: json["schedule_id"]);

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
        "check_in_time": checkInTime,
        "room": room,
        "check_in_status": checkInStatus,
        "schedule_id": scheduleId
      };
}
