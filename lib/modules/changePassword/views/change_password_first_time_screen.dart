import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/changePassword/controllers/change_password_first_time_controller.dart';

class ChangePasswordFirstTimeScreen extends StatefulWidget {
  const ChangePasswordFirstTimeScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordFirstTimeScreen> createState() =>
      _ChangePasswordFirstTimeScreenState();
}

class _ChangePasswordFirstTimeScreenState
    extends State<ChangePasswordFirstTimeScreen> {
  // ignore: unused_field
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ChangePasswordFirstTimeController _changePasswordFirstTimeController =
      Get.put(ChangePasswordFirstTimeController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                        height: h * 0.2,
                        width: w,
                        child: Image.asset('assets/images/lock.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "đặt lại mật khẩu".toUpperCase(),
                          style: TextStyle(
                              fontSize: textScale > 1.4
                                  ? 18.0.sp / textScale * 1.4
                                  : 18.0.sp,
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
                                    obscureText:
                                        _changePasswordFirstTimeController
                                            .isNewPasswordHidden.value,
                                    controller:
                                        _changePasswordFirstTimeController
                                            .newPasswordEditingController,
                                    validator: (value) =>
                                        validatePassword(value),
                                    style: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 14.0.sp / textScale * 1.4
                                          : 14.0.sp,
                                    ),
                                    decoration: inputDecoration(
                                      "Mật khẩu mới",
                                      Icons.lock,
                                      1,
                                      surfixIconData:
                                          _changePasswordFirstTimeController
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
                                    obscureText:
                                        _changePasswordFirstTimeController
                                            .isReNewPasswordHidden.value,
                                    controller:
                                        _changePasswordFirstTimeController
                                            .reNewPasswordEditingController,
                                    validator: (value) {
                                      String spacePattern = r'\s';
                                      RegExp spaceRegex = RegExp(spacePattern);
                                      if (value == null || value.isEmpty) {
                                        return 'Mật khẩu không được để trống!';
                                      } else if (value !=
                                          _changePasswordFirstTimeController
                                              .newPasswordEditingController!
                                              .text) {
                                        return 'Mật khẩu xác nhận không khớp với mật khẩu mới!';
                                      } else if (spaceRegex.hasMatch(value)) {
                                        return 'Mật khẩu không được chứa khoảng trắng!';
                                      } else if (value.length < 8) {
                                        return 'Mật khẩu cần chứa ít nhất 8 kí tự!';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                      fontSize: textScale > 1.4
                                          ? 14.0.sp / textScale * 1.4
                                          : 14.0.sp,
                                    ),
                                    decoration: inputDecoration(
                                      "Xác nhận mật khẩu mới",
                                      Icons.lock,
                                      2,
                                      surfixIconData:
                                          _changePasswordFirstTimeController
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
                                    if (_formKey.currentState!.validate() &&
                                        _changePasswordFirstTimeController
                                            .isLoading.isFalse) {
                                      await _changePasswordFirstTimeController
                                          .changePasswordFirstTime(
                                              _changePasswordFirstTimeController
                                                  .newPasswordEditingController!
                                                  .text,
                                              _changePasswordFirstTimeController
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
                                    if (_changePasswordFirstTimeController
                                        .isLoading.value) {
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
                                            'Đang cập nhật...',
                                            style: TextStyle(
                                                fontSize: textScale > 1.4
                                                    ? 14.0.sp / textScale * 1.4
                                                    : 14.0.sp,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        'cập nhật'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: textScale > 1.4
                                                ? 14.0.sp / textScale * 1.4
                                                : 14.0.sp,
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
  final ChangePasswordFirstTimeController _changePassController =
      Get.put(ChangePasswordFirstTimeController());
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    helperText: helperText,
    errorMaxLines: 3,
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
