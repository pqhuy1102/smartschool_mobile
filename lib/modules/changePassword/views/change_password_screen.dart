import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/changePassword/controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // ignore: unused_field
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ChangePasswordController _changePasswordController =
      Get.put(ChangePasswordController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue.shade900,
                size: 24.0.sp,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        height: h * 0.2,
                        width: w,
                        child: Image.asset('assets/images/lock.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "đặt lại mật khẩu".toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Obx(
                                () => TextFormField(
                                    obscureText: _changePasswordController
                                        .isOldPasswordHidden.value,
                                    controller: _changePasswordController
                                        .oldPasswordEditingController,
                                    validator: (value) =>
                                        validatePassword(value),
                                    style: TextStyle(fontSize: 14.0.sp),
                                    decoration: inputDecoration(
                                      "Mật khẩu cũ",
                                      Icons.lock,
                                      1,
                                      surfixIconData: _changePasswordController
                                              .isOldPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    )),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Obx(
                                () => TextFormField(
                                    obscureText: _changePasswordController
                                        .isNewPasswordHidden.value,
                                    controller: _changePasswordController
                                        .newPasswordEditingController,
                                    validator: (value) =>
                                        validatePassword(value),
                                    style: TextStyle(fontSize: 14.0.sp),
                                    decoration: inputDecoration(
                                      "Mật khẩu mới",
                                      Icons.lock,
                                      2,
                                      surfixIconData: _changePasswordController
                                              .isNewPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    )),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Obx(
                                () => TextFormField(
                                    obscureText: _changePasswordController
                                        .isReNewPasswordHidden.value,
                                    controller: _changePasswordController
                                        .reNewPasswordEditingController,
                                    validator: (value) =>
                                        validatePassword(value),
                                    style: TextStyle(fontSize: 14.0.sp),
                                    decoration: inputDecoration(
                                      "Xác nhận mật khẩu mới",
                                      Icons.lock,
                                      3,
                                      surfixIconData: _changePasswordController
                                              .isReNewPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    )),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _changePasswordController
                                          .changePassword(
                                              _changePasswordController
                                                  .oldPasswordEditingController!
                                                  .text,
                                              _changePasswordController
                                                  .newPasswordEditingController!
                                                  .text,
                                              _changePasswordController
                                                  .reNewPasswordEditingController!
                                                  .text);
                                    } else {
                                      setState(() {
                                        _autovalidateMode =
                                            AutovalidateMode.onUserInteraction;
                                      });
                                    }
                                  },
                                  child: Obx((() {
                                    if (_changePasswordController
                                        .isLoading.value) {
                                      return const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white)),
                                      );
                                    } else {
                                      return Text(
                                        'cập nhật'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14.0.sp,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  })),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    minimumSize: const Size.fromHeight(40),
                                    primary: Colors.blue.shade900,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0.sp),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData, int id,
    {String? prefix, String? helperText, IconData? surfixIconData}) {
  final ChangePasswordController _changePassController =
      Get.put(ChangePasswordController());
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    prefixText: prefix,
    labelStyle: TextStyle(color: Colors.blue.shade900),
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
        id == 1
            ? _changePassController.toggleOldPasswordVisibility()
            : id == 2
                ? _changePassController.toggleNewPasswordVisibility()
                : _changePassController.toggleReNewPasswordVisibility();
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

//validate password function
String? validatePassword(String? value) {
  String spacePattern = r'\s';
  RegExp spaceRegex = RegExp(spacePattern);
  if (value == null ||
      value.isEmpty ||
      spaceRegex.hasMatch(value) ||
      value.length < 8) {
    return 'Mật khẩu không hợp lệ, vui lòng nhập lại!';
  } else {
    return null;
  }
}
