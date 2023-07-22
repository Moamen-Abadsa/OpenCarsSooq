import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_route.dart';
import '../core/functions/custom_snackbar.dart';
import '../core/localization/text_language_keys.dart';

abstract class ForgotPasswordController extends GetxController {
  getUserData();
}

class ForgotPasswordControllerImp extends ForgotPasswordController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> forgotPasswordController =
      GlobalKey<FormState>(debugLabel: 'ForgotPasswordController');

  late TextEditingController tecEmail;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  getUserData() async {
    if (forgotPasswordController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      QuerySnapshot carsQuerySnapshot = await users
          .where('email', isEqualTo: tecEmail.text)
          .limit(1)
          .get()
          .whenComplete(() {
        statusRequest = StatusRequest.success;
      }).catchError((error) {
        statusRequest = StatusRequest.failure;
        print("Failed to get user email: $error");
      });

      if (statusRequest == StatusRequest.success && carsQuerySnapshot.docs.isNotEmpty) {
        final phoneNumber = '+97${carsQuerySnapshot.docs[0]['phone']}';
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {

          },
          verificationFailed: (FirebaseAuthException e) {
            print('verificationFailed ${e.toString()}');
          },
          codeSent: (String verificationId, int? resendToken) {
            print('codeSent $verificationId || $resendToken');
            Get.offNamed(AppRoute.otpVerificationScreen, arguments: {
              'verificationId': verificationId,
              'userId': carsQuerySnapshot.docs[0].id,
              'phoneNumber': phoneNumber
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print('codeAutoRetrievalTimeout $verificationId');
          },
        );
      } else {
        showSnackBar(message: emailNotFound.tr);
      }
    }

    update();
  }

  @override
  void onInit() {
    tecEmail = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    tecEmail.dispose();
    super.dispose();
  }
}
