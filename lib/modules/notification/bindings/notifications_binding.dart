import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/notification/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
