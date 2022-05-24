class ChangePasswordFirstTimeResponseModel {
  bool? isActivate;

  ChangePasswordFirstTimeResponseModel({this.isActivate});

  ChangePasswordFirstTimeResponseModel.fromJson(Map<String, dynamic> json) {
    isActivate = json['is_activate'];
  }
}
