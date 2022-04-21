import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/profile/models/profile_response_model.dart';
import 'package:smartschool_mobile/modules/profile/providers/profile_provider.dart';

class ProfileController extends GetxController {
  //manage image picker
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  var isLoading = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var _userData;
  var userName = RxString('');

  late final AuthenticationManager _authenticationManager;

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    getProfileUser();
  }

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      Get.back();
    } else {
      Get.snackbar('Warning', 'Bạn chưa chọn hình ảnh!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow.shade800,
          colorText: Colors.white);
    }
  }

  ProfileResponseModel? get userData => _userData;

  Future<void> getProfileUser() async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ProfileProvider().getProfileUser(headers);
    if (res != null) {
      _userData = res;
      userName.value = res.studentName;
      isLoading(false);
    } else {
      isLoading(false);
    }
  }
}
