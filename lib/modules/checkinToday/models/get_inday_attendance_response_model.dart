// To parse this JSON data, do
//
//     final getIndayAttendanceResponseModel = getIndayAttendanceResponseModelFromJson(jsonString);

import 'dart:convert';

GetIndayAttendanceResponseModel getIndayAttendanceResponseModelFromJson(
        String str) =>
    GetIndayAttendanceResponseModel.fromJson(json.decode(str));

String getIndayAttendanceResponseModelToJson(
        GetIndayAttendanceResponseModel data) =>
    json.encode(data.toJson());

class GetIndayAttendanceResponseModel {
  GetIndayAttendanceResponseModel({
    required this.checkinList,
  });

  List<CheckinList> checkinList;

  factory GetIndayAttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      GetIndayAttendanceResponseModel(
        checkinList: List<CheckinList>.from(
            json["checkin_list"].map((x) => CheckinList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "checkin_list": List<dynamic>.from(checkinList.map((x) => x.toJson())),
      };
}

class CheckinList {
  CheckinList(
      {required this.course,
      required this.startTime,
      required this.endTime,
      required this.checkInTime,
      required this.room,
      required this.checkInStatus});

  String course;
  String startTime;
  String endTime;
  dynamic checkInTime;
  String room;
  dynamic checkInStatus;

  factory CheckinList.fromJson(Map<String, dynamic> json) => CheckinList(
      course: json["course"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      checkInTime: json["check_in_time"],
      room: json["room"],
      checkInStatus: json["check_in_status"]);

  Map<String, dynamic> toJson() => {
        "course": course,
        "start_time": startTime,
        "end_time": endTime,
        "check_in_time": checkInTime,
        "room": room,
        "check_in_status": checkInStatus
      };
}
