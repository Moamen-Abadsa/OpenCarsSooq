import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localization/text_language_keys.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: alertExitTitle.tr,
      middleText: alertExitBody.tr,
      actions: [
        ElevatedButton(onPressed: () => exit(0), child: Text(yes.tr)),
        ElevatedButton(onPressed: () => Get.back(), child: Text(no.tr)),
      ]);
  return Future.value(true);
}
