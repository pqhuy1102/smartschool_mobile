import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/views/login_screen.dart';
import 'package:smartschool_mobile/modules/changePassword/views/change_password_first_time_screen.dart';
import 'package:smartschool_mobile/modules/changePassword/views/change_password_screen.dart';
import 'package:smartschool_mobile/modules/complain/views/add_complain_screen.dart';
import 'package:smartschool_mobile/modules/complain/views/complain_list_screen.dart';
import 'package:smartschool_mobile/modules/complain/views/detail_complain_form_screen.dart';
import 'package:smartschool_mobile/modules/dashboard/views/dashboard_screen.dart';
import 'package:smartschool_mobile/modules/late/views/add_late_screen.dart';
import 'package:smartschool_mobile/modules/late/views/choose_date_screen.dart';
import 'package:smartschool_mobile/modules/late/views/detail_late_form_screen.dart';
import 'package:smartschool_mobile/modules/late/views/late_application_form_list_screen.dart';
import 'package:smartschool_mobile/modules/resetPassword/views/reset_password_screen.dart';
import 'package:smartschool_mobile/modules/notification/bindings/notifications_binding.dart';
import 'package:smartschool_mobile/modules/notification/views/notification_screen.dart';
import 'package:smartschool_mobile/modules/profile/bindings/profile_bindings.dart';
import 'package:smartschool_mobile/modules/profile/views/profile_screen.dart';
import 'package:smartschool_mobile/modules/qrcode/views/qrcode_screen.dart';
import 'package:smartschool_mobile/modules/report/views/report_screen.dart';
import 'package:smartschool_mobile/modules/report/views/detail_subject_report_screen.dart';
import 'package:smartschool_mobile/modules/setttings/bindings/settings_binding.dart';
import 'package:smartschool_mobile/modules/setttings/views/setttings_screen.dart';
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
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashBoardScreen(),
        children: [
          GetPage(name: Routes.qrcode, page: () => const QRCodeScreen()),
          GetPage(name: Routes.report, page: () => const ReportScreen()),
          GetPage(
              name: Routes.profile,
              page: () => const ProfileScreen(),
              binding: ProfileBinding()),
          GetPage(
              name: Routes.settings,
              page: () => SettingsScreen(),
              binding: SettingsBinding(),
              children: [
                GetPage(
                    name: Routes.changePassword,
                    page: () => const ChangePasswordScreen()),
              ]),
          GetPage(
            name: Routes.notification,
            page: () => NotificationScreen(),
            binding: NotificationsBinding(),
          ),
        ]),
    GetPage(
        name: Routes.subjectDetailReport,
        page: () => SubjectDetailReportScreen()),
    GetPage(name: Routes.addComplain, page: () => const AddComplainScreen()),
    GetPage(
        name: Routes.complainList,
        page: () => const ComplainListScreen(),
        children: [
          GetPage(
              name: Routes.detailComplainForm,
              page: () => const DetailComplainFormScreen()),
        ]),
    GetPage(
        name: Routes.lateApplicationFormList,
        page: () => const LateApplicationFormListScreen(),
        children: [
          GetPage(
              name: Routes.detailLateForm,
              page: () => const DetailLateFormScreen()),
          GetPage(
              name: Routes.chooseDateForLate,
              page: () => const ChooseDateForLateScreen(),
              children: [
                GetPage(
                    name: Routes.addLate, page: () => const AddLateScreen()),
              ]),
        ]),
    GetPage(
        name: Routes.changePasswordFirstTime,
        page: () => const ChangePasswordFirstTimeScreen()),
    GetPage(
        name: Routes.forgotPassword, page: () => const ResetPasswordScreen()),
  ];
}
