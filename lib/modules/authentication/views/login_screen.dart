// ignore_for_file: unnecessary_new, unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_image.jpg'),
                  fit: BoxFit.fill)),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                  height: h * 0.16,
                  width: w,
                  child: Image.asset('assets/images/logo-hcmus-new.png'),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'đăng nhập'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    )),
                //Login form
                Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller:
                                  _loginController.emailEditingController,
                              validator: (value) => validateEmail(value),
                              style: TextStyle(fontSize: 14.0.sp),
                              decoration: inputDecoration(
                                  'Email của bạn', Icons.email),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => TextFormField(
                                obscureText:
                                    _loginController.isPasswordHidden.value,
                                controller:
                                    _loginController.passwordEditingController,
                                validator: (value) => validatePassword(value),
                                style: TextStyle(fontSize: 14.0.sp),
                                decoration: inputDecoration(
                                    'Mật khẩu của bạn', Icons.lock,
                                    surfixIconData:
                                        _loginController.isPasswordHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Quên mật khẩu?',
                                      style: TextStyle(
                                          fontSize: 14.0.sp,
                                          color: Colors.black),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await _loginController.login(
                                        _loginController
                                            .emailEditingController!.text,
                                        _loginController
                                            .passwordEditingController!.text);
                                  }
                                },
                                child: Obx((() {
                                  if (_loginController.isLoading.value) {
                                    return const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white));
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
                                  minimumSize: const Size.fromHeight(60),
                                  primary: Colors.blue.shade900,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0.sp),
                                  ),
                                ))
                          ],
                        )))
              ],
            ),
          ),
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
String? validateEmail(String? value) {
  String emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp emailRegex = RegExp(emailPattern);
  if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
    return 'Email không hợp lệ, vui lòng nhập lại!';
  } else {
    return null;
  }
}

//validate password function
String? validatePassword(String? value) {
  String spacePattern = r'\s';
  RegExp spaceRegex = RegExp(spacePattern);
  if (value == null || value.isEmpty || spaceRegex.hasMatch(value)) {
    return 'Mật khẩu cần đủ 8 kí tự, không chứa khoảng trắng, vui lòng nhập lại!';
  } else {
    return null;
  }
}
