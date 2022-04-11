import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/checkinToday/controllers/get_inday_attendance_controller.dart';

class GetIndayAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetIndayAttendanceController());
  }
}
