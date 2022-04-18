class UpdateNotificationTokenRequestModel {
  String? notificationToken;

  UpdateNotificationTokenRequestModel({this.notificationToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_token'] = notificationToken;
    return data;
  }
}
