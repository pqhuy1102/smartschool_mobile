// To parse this JSON data, do
//
//     final userSemestersResponseModel = userSemestersResponseModelFromJson(jsonString);

import 'dart:convert';

UserSemestersResponseModel userSemestersResponseModelFromJson(String str) =>
    UserSemestersResponseModel.fromJson(json.decode(str));

String userSemestersResponseModelToJson(UserSemestersResponseModel data) =>
    json.encode(data.toJson());

class UserSemestersResponseModel {
  UserSemestersResponseModel({
    required this.semesterList,
  });

  List<SemesterList> semesterList;

  factory UserSemestersResponseModel.fromJson(Map<String, dynamic> json) =>
      UserSemestersResponseModel(
        semesterList: List<SemesterList>.from(
            json["semester_list"].map((x) => SemesterList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "semester_list":
            List<dynamic>.from(semesterList.map((x) => x.toJson())),
      };
}

class SemesterList {
  SemesterList({
    required this.id,
    required this.title,
    required this.year,
  });

  int id;
  String title;
  String year;

  factory SemesterList.fromJson(Map<String, dynamic> json) => SemesterList(
        id: json["id"],
        title: json["title"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
      };
}
