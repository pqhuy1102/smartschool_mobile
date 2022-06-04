class ResetPasswordResponseModel {
  String? message;

  ResetPasswordResponseModel({this.message});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
