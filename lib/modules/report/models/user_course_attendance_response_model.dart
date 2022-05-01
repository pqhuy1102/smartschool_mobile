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
  AttendanceList({
    required this.startTime,
    required this.endTime,
    required this.checkInTime,
    required this.room,
    required this.checkInStatus,
  });

  DateTime startTime;
  DateTime endTime;
  DateTime? checkInTime;
  String room;
  String checkInStatus;

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        checkInTime: json["check_in_time"] == null
            ? null
            : DateTime.parse(json["check_in_time"]),
        room: json["room"],
        checkInStatus: json["check_in_status"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        // ignore: prefer_null_aware_operators, unnecessary_null_comparison
        "check_in_time":
            // ignore: prefer_null_aware_operators
            checkInTime == null ? null : checkInTime?.toIso8601String(),
        "room": room,
        "check_in_status": checkInStatus,
      };
}
