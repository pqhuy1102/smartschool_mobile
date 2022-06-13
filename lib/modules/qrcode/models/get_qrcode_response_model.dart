import 'dart:convert';

GetQrCodeResponseModel getQrCodeResponseModelFromJson(String str) =>
    GetQrCodeResponseModel.fromJson(json.decode(str));

String getQrCodeResponseModelToJson(GetQrCodeResponseModel data) =>
    json.encode(data.toJson());

class GetQrCodeResponseModel {
  GetQrCodeResponseModel({
    required this.qrString,
  });

  String qrString;

  factory GetQrCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetQrCodeResponseModel(
        qrString: json["qr_string"],
      );

  Map<String, dynamic> toJson() => {
        "qr_string": qrString,
      };
}
