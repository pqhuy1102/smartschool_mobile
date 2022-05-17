class LoginResponseModel {
  String? token;
  String? username;
  bool? isActivate;

  LoginResponseModel({this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
    isActivate = json['is_activate'];
  }
}
