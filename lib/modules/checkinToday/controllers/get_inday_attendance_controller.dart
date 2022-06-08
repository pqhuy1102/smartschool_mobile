import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/checkinToday/providers/get_inday_attendance_provider.dart';

class GetIndayAttendanceController extends GetxController {
  final isLoading = false.obs;

  late final AuthenticationManager _authenticationManager;

  late final GetIndayAttendanceProvider _getIndayAttendanceProvider;

  var indayAttendanceList = [].obs;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    _getIndayAttendanceProvider = Get.put(GetIndayAttendanceProvider());

    // getIndayAttendance();
  }

  Future<void> getIndayAttendance() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await _getIndayAttendanceProvider.getIndayAttendance(headers);
    indayAttendanceList.value = res;
  }
}
