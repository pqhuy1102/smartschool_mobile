import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/checkinToday/providers/get_inday_attendance_provider.dart';

class GetIndayAttendanceController extends GetxController {
  var hasInternet = false.obs;

  final isLoading = false.obs;

  late final AuthenticationManager _authenticationManager;

  late final GetIndayAttendanceProvider _getIndayAttendanceProvider;

  //initialize inday attendance list
  var indayAttendanceList = [].obs;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    _getIndayAttendanceProvider = Get.put(GetIndayAttendanceProvider());

    getInternetStatus();

    getIndayAttendance();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternetYet = status == InternetConnectionStatus.connected;
      hasInternet.value = hasInternetYet;
      if (hasInternet.isTrue) {
        getIndayAttendance();
      }
    });
  }

  Future<void> getIndayAttendance() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    isLoading(true);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String today = formatter.format(now);
    var res =
        await _getIndayAttendanceProvider.getIndayAttendance(headers, today);
    if (res != null) {
      isLoading(false);
      indayAttendanceList.value = res;
    } else {
      isLoading(false);
    }
  }

  void getInternetStatus() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
  }
}
