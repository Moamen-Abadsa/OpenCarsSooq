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

abstract class LoginController extends GetxController {
  login();

  checkRememberMer(newValue);
}

class LoginControllerImp extends LoginController {
  final GlobalKey<FormState> loginFormState =
      GlobalKey<FormState>(debugLabel: 'loginFormState');
  late TextEditingController tecEmail;
  late TextEditingController tecPassword;

  bool checkedValue = false;

  StatusRequest statusRequest = StatusRequest.none;

  AppServices appServices = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;
  late CollectionReference stores;

  @override
  checkRememberMer(newValue) {
    checkedValue = newValue;
    update();
  }

  @override
  login() async {
    if (loginFormState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      QuerySnapshot querySnapshot = await users
          .where('email', isEqualTo: tecEmail.text)
          .where('password', isEqualTo: generateMd5(tecPassword.text))
          .limit(1)
          .get()
          .whenComplete(() => statusRequest = StatusRequest.success)
          .catchError((error) {
        statusRequest = StatusRequest.failure;
        print("Failed to login: $error");
      });

      if(querySnapshot.docs.isNotEmpty) {
        appServices.sharedPreferences.setBool(SharedPrefKeys.IS_REMEMBER_ME, checkedValue);
        appServices.sharedPreferences.setString(SharedPrefKeys.USER_ID, querySnapshot.docs[0].id);
        appServices.sharedPreferences.setString(SharedPrefKeys.USER_NAME, querySnapshot.docs[0]['name']);
        appServices.sharedPreferences.setString(SharedPrefKeys.USER_EMAIL, querySnapshot.docs[0]['email']);
        appServices.sharedPreferences.setString(SharedPrefKeys.USER_ADDRESS, querySnapshot.docs[0]['address']);
        appServices.sharedPreferences.setString(SharedPrefKeys.USER_PHONE, querySnapshot.docs[0]['phone']);
        appServices.sharedPreferences.setBool(SharedPrefKeys.IS_VENDOR, querySnapshot.docs[0]['isVendor']);

        if(querySnapshot.docs[0]['isVendor'] == true) {
          QuerySnapshot storeQuerySnapshot = await stores
              .where('vendorId', isEqualTo: querySnapshot.docs[0].id)
              .limit(1)
              .get()
              .whenComplete(() => statusRequest = StatusRequest.success)
              .catchError((error) {
            statusRequest = StatusRequest.failure;
            print("Failed to vendorId: $error");
          });

          appServices.sharedPreferences.setString(SharedPrefKeys.STORE_ID, storeQuerySnapshot.docs[0].id);
        }

        Get.offNamed(AppRoute.mainScreen);
      } else {
        showSnackBar(message: emailOrPasswordNotCorrect.tr);
      }

      update();
    }
  }

  @override
  void onInit() {
    tecEmail = TextEditingController();
    tecPassword = TextEditingController();
    stores = firestore.collection('stores');
    users = firestore.collection('users');
    super.onInit();
  }

  @override
  void dispose() {
    tecEmail.dispose();
    tecPassword.dispose();
    super.dispose();
  }
}
