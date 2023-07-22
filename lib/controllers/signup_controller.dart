import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:opencarssooq/core/services/services.dart';

import '../core/class/status_request.dart';
import '../core/functions/check_email.dart';
import '../core/functions/md5_encrypt.dart';
import '../core/localization/text_language_keys.dart';
import '../data/models/user.dart';
import '../views/screens/auth/sign_up_store_screen.dart';

abstract class SignUpController extends GetxController {
  checkVendor(bool newValue);

  saveUser();

  updateUserData();
}

class SignUpControllerImp extends SignUpController {
  bool isVendor = false;
  String titleButton = signUp.tr;

  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> signUpController =
      GlobalKey<FormState>(debugLabel: 'signUpController');

  late TextEditingController tecName;
  late TextEditingController tecEmail;
  late TextEditingController tecPhone;
  late TextEditingController tecAddress;
  late TextEditingController tecPassword;
  late TextEditingController tecRePassword;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  AppServices appServices = Get.find();

  @override
  checkVendor(bool newValue) {
    isVendor = newValue;
    newValue == true ? titleButton = Continue.tr : titleButton = signUp.tr;
    update();
  }

  @override
  saveUser() async {
    if (signUpController.currentState!.validate()) {
      if (tecPassword.text == tecRePassword.text) {
        statusRequest = StatusRequest.loading;
        update();

        User user = User(
            name: tecName.text,
            email: tecEmail.text,
            address: tecAddress.text,
            phone: tecPhone.text,
            password: generateMd5(tecPassword.text),
            isVendor: isVendor);

        if (await checkEmail(users, tecEmail.text) == true) {
          statusRequest = StatusRequest.success;
          update();
          return;
        }

        users.add(user.toJson()).then((value) {
          statusRequest = StatusRequest.success;

          if (isVendor) {
            Get.toNamed(AppRoute.signUpStoreScreen,
                arguments: {'userId': value.id});
          } else {
            Get.offNamed(AppRoute.loginScreen);
          }
        }).catchError((error) {
          statusRequest = StatusRequest.failure;
          print("Failed to add user: $error");
        });

        update();
      } else {
        showSnackBar(message: passwordAndRePasswordNotMatched.tr);
      }
    }
  }

  @override
  updateUserData() async {
    if (signUpController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic> user = {
        'name': tecName.text,
        'email': tecEmail.text,
        'address': tecAddress.text,
        'phone': tecPhone.text
      };

      if (tecEmail.text !=
          appServices.getStringSharedPreferences(SharedPrefKeys.USER_EMAIL)) {
        if (await checkEmail(users, tecEmail.text) == true) {
          statusRequest = StatusRequest.success;
          update();
          return;
        }
      }

      users
          .doc(appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID))
          .update(user)
          .whenComplete(() {
        statusRequest = StatusRequest.success;
        appServices.sharedPreferences
            .setString(SharedPrefKeys.USER_NAME, tecName.text);
        appServices.sharedPreferences
            .setString(SharedPrefKeys.USER_EMAIL, tecEmail.text);
        appServices.sharedPreferences
            .setString(SharedPrefKeys.USER_ADDRESS, tecAddress.text);
        appServices.sharedPreferences
            .setString(SharedPrefKeys.USER_PHONE, tecPhone.text);

        Get.back();
      }).catchError((error) {
        statusRequest = StatusRequest.failure;
        print("Failed to update user: $error");
      });

      update();
    }
  }

  @override
  void onInit() {
    tecName = TextEditingController();
    tecEmail = TextEditingController();
    tecPhone = TextEditingController();
    tecAddress = TextEditingController();
    tecPassword = TextEditingController();
    tecRePassword = TextEditingController();
    if (Get.currentRoute == AppRoute.profileScreen) {
      tecName.text =
          appServices.getStringSharedPreferences(SharedPrefKeys.USER_NAME);
      tecEmail.text =
          appServices.getStringSharedPreferences(SharedPrefKeys.USER_EMAIL);
      tecAddress.text =
          appServices.getStringSharedPreferences(SharedPrefKeys.USER_ADDRESS);
      tecPhone.text =
          appServices.getStringSharedPreferences(SharedPrefKeys.USER_PHONE);
    }
    super.onInit();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecEmail.dispose();
    tecPhone.dispose();
    tecAddress.dispose();
    tecPassword.dispose();
    tecRePassword.dispose();
    super.dispose();
  }
}
