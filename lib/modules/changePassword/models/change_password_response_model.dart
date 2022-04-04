class ChangePasswordResponseModel {
  String? oldPassword;
  String? newPassword;
  String? reNewPassword;

  ChangePasswordResponseModel(
      {this.oldPassword, this.newPassword, this.reNewPassword});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    reNewPassword = json['re_new_password'];
  }
}
