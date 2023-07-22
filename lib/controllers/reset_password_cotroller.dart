import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:opencarssooq/core/functions/md5_encrypt.dart';
import '../core/class/status_request.dart';
import '../core/constant/app_route.dart';
import '../core/constant/shared_preference_keys.dart';
import '../core/functions/handling_data_controller.dart';
import '../core/localization/text_language_keys.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/login_data.dart';
import '../data/models/user.dart';

abstract class ResetPasswordController extends GetxController {
  saveNewPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  final GlobalKey<FormState> resetPasswordControllerImp =
      GlobalKey<FormState>(debugLabel: 'resetPasswordControllerImp');
  late TextEditingController tecNewPassword;
  late TextEditingController tecReNewPassword;

  StatusRequest statusRequest = StatusRequest.none;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;

  @override
  saveNewPassword() async {
    if (resetPasswordControllerImp.currentState!.validate()) {
      if (tecNewPassword.text == tecReNewPassword.text) {
        statusRequest = StatusRequest.loading;
        update();

        Map<String, dynamic> map = {
          'password': generateMd5(tecNewPassword.text)
        };

        await users.doc(Get.arguments['userId']).update(map).whenComplete(() {
          statusRequest = StatusRequest.success;
        }).catchError((error) {
          statusRequest = StatusRequest.failure;
          print("Failed to update password: $error");
        });

        if (statusRequest == StatusRequest.success) {
          Get.offNamed(AppRoute.loginScreen);
        }

        update();
      } else {
        showSnackBar(message: passwordAndRePasswordNotMatched.tr);
      }
    }
  }

  @override
  void onInit() {
    tecNewPassword = TextEditingController();
    tecReNewPassword = TextEditingController();
    users = firestore.collection('users');
    super.onInit();
  }

  @override
  void dispose() {
    tecNewPassword.dispose();
    tecReNewPassword.dispose();
    super.dispose();
  }
}
