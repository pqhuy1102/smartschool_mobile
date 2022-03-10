import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/dashboard/views/dashboard_screen.dart';
import 'package:smartschool_mobile/modules/profile/views/profile_screen.dart';
import 'package:smartschool_mobile/modules/qrcode/views/qrcode_screen.dart';
import 'package:smartschool_mobile/modules/report/views/report_screen.dart';
import 'package:smartschool_mobile/modules/splash/views/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashBoardScreen(),
        children: [
          GetPage(name: Routes.qrcode, page: () => const QRCodeScreen()),
          GetPage(name: Routes.report, page: () => const ReportScreen()),
          GetPage(name: Routes.profile, page: () => const ProfileScreen()),
        ]),
  ];
}
