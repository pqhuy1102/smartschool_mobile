class ChangePasswordFirstTimeResponseModel {
  bool? isActivate;
  late String message;

  ChangePasswordFirstTimeResponseModel(
      {this.isActivate, required this.message});

  ChangePasswordFirstTimeResponseModel.fromJson(Map<String, dynamic> json) {
    isActivate = json['is_activate'];
    message = json['message'];
  }
}
