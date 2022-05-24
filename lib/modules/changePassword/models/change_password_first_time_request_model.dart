class ChangePasswordFirstTimeRequestModel {
  String? newPassword;
  String? reNewPassword;

  ChangePasswordFirstTimeRequestModel({this.newPassword, this.reNewPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_password'] = newPassword;
    data['re_new_password'] = reNewPassword;
    return data;
  }
}
