// To parse this JSON data, do
//
//     final detailComplainFormResponseModel = detailComplainFormResponseModelFromJson(jsonString);

import 'dart:convert';

DetailComplainFormResponseModel detailComplainFormResponseModelFromJson(
        String str) =>
    DetailComplainFormResponseModel.fromJson(json.decode(str));

String detailComplainFormResponseModelToJson(
        DetailComplainFormResponseModel data) =>
    json.encode(data.toJson());

class DetailComplainFormResponseModel {
  DetailComplainFormResponseModel({
    required this.formDetail,
  });

  FormDetail formDetail;

  factory DetailComplainFormResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailComplainFormResponseModel(
        formDetail: FormDetail.fromJson(json["form_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "form_detail": formDetail.toJson(),
      };
}

class FormDetail {
  FormDetail({
    required this.courseName,
    required this.startTime,
    required this.endTime,
    required this.room,
    this.checkinTime,
    required this.currentStatus,
    required this.requestStatus,
    required this.teacherName,
    required this.formStatus,
    required this.reason,
    required this.rejectReason,
  });

  String courseName;
  String startTime;
  String endTime;
  String room;
  dynamic checkinTime;
  String currentStatus;
  String requestStatus;
  String teacherName;
  String formStatus;
  String reason;
  String rejectReason;

  factory FormDetail.fromJson(Map<String, dynamic> json) => FormDetail(
        courseName: json["course_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        room: json["room"],
        checkinTime: json["checkin_time"],
        currentStatus: json["current_status"],
        requestStatus: json["request_status"],
        teacherName: json["teacher_name"],
        formStatus: json["form_status"],
        reason: json["reason"],
        rejectReason: json["reject_reason"],
      );

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
        "start_time": startTime,
        "end_time": endTime,
        "room": room,
        "checkin_time": checkinTime,
        "current_status": currentStatus,
        "request_status": requestStatus,
        "teacher_name": teacherName,
        "form_status": formStatus,
        "reason": reason,
        "reject_reason": rejectReason,
      };
}
