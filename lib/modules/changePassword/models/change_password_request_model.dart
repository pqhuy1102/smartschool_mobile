class ChangePasswordRequestModel {
  String? oldPassword;
  String? newPassword;
  String? reNewPassword;

  ChangePasswordRequestModel(
      {this.oldPassword, this.newPassword, this.reNewPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    data['re_new_password'] = reNewPassword;
    return data;
  }
}
