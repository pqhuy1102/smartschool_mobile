import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

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
}
