import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:smartschool_mobile/constants.dart';
import 'package:smartschool_mobile/modules/qrcode/models/get_qrcode_response_model.dart';

class GetQrCodeProvider extends GetConnect {
  final String getQrCodeUrl = '${Constant.apiDomain}/user/get-qr';

  Future<dynamic> getQrCode(headers) async {
    final response = await get(getQrCodeUrl, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      return getQrCodeResponseModelFromJson(response.bodyString!);
    } else if (response.status.isUnauthorized) {
      return 'unauthorized';
    } else {
      return null;
    }
  }
}
