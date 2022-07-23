class RequestComplainRequestModel {
  int scheduleId;
  String requestCheckinStatus;
  int toUserId;
  String reason;

  RequestComplainRequestModel(
      {required this.scheduleId,
      required this.requestCheckinStatus,
      required this.toUserId,
      required this.reason});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule_id'] = scheduleId;
    data['request_checkin_status'] = requestCheckinStatus;
    data['to_user_id'] = toUserId;
    data['reason'] = reason;
    return data;
  }
}
