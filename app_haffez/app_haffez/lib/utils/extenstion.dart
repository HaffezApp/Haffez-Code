import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/core/view_model/loader.dart';

extension StringExtensions on String {
  bool isValidEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool isValidPassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(this);
}

extension CustomExtenstionGetInterface on GetInterface {
  void customSnackbar({
    required String title,
    required String message,
     Duration duration =const Duration(seconds: 3),
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }

  void customLoader({bool isShowLoader = true}) {
    Get.find<LoaderViewModel>().showLoader(isShowLoader: isShowLoader);
  }
}
