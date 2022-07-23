// To parse this JSON data, do
//
//     final complainFormResponeModel = complainFormResponeModelFromJson(jsonString);

import 'dart:convert';

ComplainFormResponeModel complainFormResponeModelFromJson(String str) =>
    ComplainFormResponeModel.fromJson(json.decode(str));

String complainFormResponeModelToJson(ComplainFormResponeModel data) =>
    json.encode(data.toJson());

class ComplainFormResponeModel {
  ComplainFormResponeModel({
    this.checkInTime,
    required this.courseName,
    required this.currentCheckInStatus,
    required this.endTime,
    required this.requestStatus,
    required this.room,
    required this.scheduleId,
    required this.startTime,
    required this.teacherList,
  });

  String? checkInTime;
  String courseName;
  String currentCheckInStatus;
  String endTime;
  List<String> requestStatus;
  String room;
  int scheduleId;
  String startTime;
  List<TeacherList> teacherList;

  factory ComplainFormResponeModel.fromJson(Map<String, dynamic> json) =>
      ComplainFormResponeModel(
        checkInTime: json["check_in_time"],
        courseName: json["course_name"],
        currentCheckInStatus: json["current_check_in_status"],
        endTime: json["end_time"],
        requestStatus: List<String>.from(json["request_status"].map((x) => x)),
        room: json["room"],
        scheduleId: json["schedule_id"],
        startTime: json["start_time"],
        teacherList: List<TeacherList>.from(
            json["teacher_list"].map((x) => TeacherList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "check_in_time": checkInTime,
        "course_name": courseName,
        "current_check_in_status": currentCheckInStatus,
        "end_time": endTime,
        "request_status": List<dynamic>.from(requestStatus.map((x) => x)),
        "room": room,
        "schedule_id": scheduleId,
        "start_time": startTime,
        "teacher_list": List<dynamic>.from(teacherList.map((x) => x.toJson())),
      };
}

class TeacherList {
  TeacherList({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory TeacherList.fromJson(Map<String, dynamic> json) => TeacherList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
