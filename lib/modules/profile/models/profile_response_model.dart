// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) =>
    ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) =>
    json.encode(data.toJson());

class ProfileResponseModel {
  ProfileResponseModel({
    required this.studentName,
    required this.studentClass,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.studentId,
  });

  String studentName;
  String studentClass;
  String email;
  String phoneNumber;
  String gender;
  String studentId;

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        studentName: json["student_name"],
        studentClass: json["student_class"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        studentId: json["student_id"],
      );

  Map<String, dynamic> toJson() => {
        "student_name": studentName,
        "student_class": studentClass,
        "email": email,
        "phone_number": phoneNumber,
        "gender": gender,
        "student_id": studentId,
      };
}
