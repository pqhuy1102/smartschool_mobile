import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/modules/authentication/views/login_screen.dart';
import 'package:smartschool_mobile/modules/changePassword/views/change_password_first_time_screen.dart';
import 'package:smartschool_mobile/modules/dashboard/views/dashboard_screen.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.put(AuthenticationManager());
    LoginController _loginController = Get.put(LoginController());

    return Obx(() {
      // return (_authManager.isLogged.value &&
      //         (_loginController.isActivated.value ||
      //                 _authManager.isActivated.value) ==
      //             true)
      //     ? const DashBoardScreen()
      //     : (_authManager.isLogged.value &&
      //             (_loginController.isActivated.value ||
      //                     _authManager.isActivated.value) !=
      //                 false)
      //         ? const ChangePasswordFirstTimeScreen()
      //         : const LoginScreen();
      if (_authManager.isLogged.value == true) {
        if (_loginController.isActivated.value ||
            _authManager.isActivated.value) {
          return const DashBoardScreen();
        } else {
          return const ChangePasswordFirstTimeScreen();
        }
      } else {
        return const LoginScreen();
      }
    });
  }
}
