import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/dashboard/dashboard_screen.dart';
import 'package:smartschool_mobile/modules/dashboard/qrcode_screen.dart';
import 'package:smartschool_mobile/modules/dashboard/report_screen.dart';
import 'package:smartschool_mobile/modules/splash/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashBoardScreen(),
        children: [
          GetPage(name: Routes.qrcode, page: () => const QRCodeScreen()),
          GetPage(name: Routes.report, page: () => const ReportScreen())
        ]),
  ];
}