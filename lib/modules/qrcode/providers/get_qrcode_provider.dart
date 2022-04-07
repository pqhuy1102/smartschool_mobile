import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/modules/qrcode/models/get_qrcode_response_model.dart';

class GetQrCodeProvider extends GetConnect {
  final String getQrCodeUrl = 'http://13.228.244.196:6002/user/get-qr';

  Future<GetQrCodeResponseModel?> getQrCode(headers) async {
    final response = await get(getQrCodeUrl, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return getQrCodeResponseModelFromJson(response.bodyString!);
    } else {
      return null;
    }
  }
}
