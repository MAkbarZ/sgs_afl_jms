import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SGSSnackbar {
  SGSSnackbar._();

  static SnackbarController getSnackbarGreen(String title, String message) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }

  static SnackbarController getSnackbarRed(String title, String message) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
}
