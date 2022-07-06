import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';
import 'package:smartschool_mobile/routes/app_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_login.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: 25.0.h,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      'đăng nhập'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    )),
                //Login form
                Container(
                    margin: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller:
                                  _loginController.emailEditingController,
                              validator: (value) => validateMSSV(value),
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500),
                              decoration: inputDecoration(
                                'Mã số sinh viên',
                                Icons.person_pin,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => TextFormField(
                                obscureText:
                                    _loginController.isPasswordHidden.value,
                                controller:
                                    _loginController.passwordEditingController,
                                validator: (value) => validatePassword(value),
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w500),
                                decoration: inputDecoration(
                                  'Mật khẩu',
                                  Icons.lock,
                                  surfixIconData:
                                      _loginController.isPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.forgotPassword);
                                    },
                                    child: Text(
                                      'Quên mật khẩu?',
                                      style: TextStyle(
                                          fontSize: 13.0.sp,
                                          color: Colors.black),
                                    ))),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      _loginController.isLoading.isFalse) {
                                    await _loginController.login(
                                        _loginController
                                            .emailEditingController!.text,
                                        _loginController
                                            .passwordEditingController!.text);
                                  } else {
                                    setState(() {
                                      _autovalidateMode =
                                          AutovalidateMode.onUserInteraction;
                                    });
                                  }
                                },
                                child: Obx((() {
                                  if (_loginController.isLoading.value) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'Đang đăng nhập...',
                                          style: TextStyle(
                                              fontSize: 14.0.sp,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Text(
                                      'đăng nhập'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                })),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  minimumSize: const Size.fromHeight(40),
                                  primary: Colors.blue.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0.sp),
                                  ),
                                ))
                          ],
                        )))
              ],
            ),
          )),
        ));
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText, IconData? surfixIconData}) {
  final LoginController _loginController = Get.put(LoginController());

  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.blue.shade900),
    prefixText: prefix,
    errorMaxLines: 3,
    prefixIcon: Icon(
      iconData,
      size: 20.0.sp,
      color: Colors.blue.shade900,
    ),
    suffix: InkWell(
      child: Icon(
        surfixIconData,
        color: Colors.grey,
        size: 20.0.sp,
      ),
      onTap: () {
        _loginController.togglePasswordVisibility();
      },
    ),
    errorStyle: TextStyle(
        color: Colors.red, fontWeight: FontWeight.w500, fontSize: 12.0.sp),
    prefixIconConstraints: const BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue.shade900)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black)),
  );
}

//validate email function
String? validateMSSV(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mã số sinh viên không hợp lệ, vui lòng nhập lại!';
  } else {
    return null;
  }
}

//validate password function
String? validatePassword(String? value) {
  String spacePattern = r'\s';
  RegExp spaceRegex = RegExp(spacePattern);

  if (value == null || value.isEmpty) {
    return 'Mật khẩu không được để trống!';
  } else if (spaceRegex.hasMatch(value)) {
    return 'Mật khẩu không được chứa khoảng trắng!';
  } else if (value.length < 8) {
    return 'Mật khẩu cần chứa ít nhất 8 kí tự!';
  } else {
    return null;
  }
}
