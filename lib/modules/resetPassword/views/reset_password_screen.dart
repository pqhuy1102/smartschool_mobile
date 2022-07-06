import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/resetPassword/controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordController _resetPasswordController =
      Get.put(ResetPasswordController());
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    "quên mật khẩu".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                    child: Center(
                      child: Text(
                        'Chọn “Gửi” để nhận email hướng dẫn đặt lại mật khẩu đến email sinh viên của bạn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                    )),
                Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          child: TextFormField(
                            controller:
                                _resetPasswordController.emailEditingController,
                            validator: (value) => validateEmail(value),
                            style: TextStyle(fontSize: 14.0.sp),
                            decoration:
                                inputDecoration('Email của bạn', Icons.email),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    _resetPasswordController
                                        .isLoading.isFalse) {
                                  await _resetPasswordController.resetPassword(
                                      _resetPasswordController
                                          .emailEditingController!.text);
                                } else {
                                  setState(() {
                                    _autovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });
                                }
                              },
                              child: Obx((() {
                                if (_resetPasswordController.isLoading.value) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        'Đang gửi đi...',
                                        style: TextStyle(
                                            fontSize: 14.0.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  );
                                } else {
                                  return Text(
                                    'gửi'.toUpperCase(),
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
                                primary:
                                    _resetPasswordController.isLoading.value
                                        ? Colors.grey
                                        : Colors.blue.shade900,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0.sp),
                                ),
                              )),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText, IconData? surfixIconData}) {
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
