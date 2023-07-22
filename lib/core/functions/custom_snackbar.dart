import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({String? title, required String message}) {
  Get.rawSnackbar(
      messageText: Text(
    message,
    textAlign: TextAlign.right,
    style: const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
  ));
}
