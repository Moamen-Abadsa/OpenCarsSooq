import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_route.dart';
import '../core/localization/text_language_keys.dart';

abstract class OtpController extends GetxController {
  checkOtp(String verificationCode);

  startCounter();

  resendOTP();
}

class OtpControllerImp extends OtpController {

  StatusRequest statusRequest = StatusRequest.none;

  Timer? timer;
  int start = 60;

  @override
  checkOtp(String verificationCode) async {
    if(start != 0) {
      statusRequest = StatusRequest.loading;
      update();

      PhoneAuthCredential c = PhoneAuthProvider.credential(
          verificationId: Get.arguments['verificationId'],
          smsCode: verificationCode);

      await FirebaseAuth.instance.signInWithCredential(c)
          .then((value) {
        try {
          Get.offNamed(AppRoute.confirmPasswordScreen,
              arguments: {'userId': Get.arguments['userId']});
        } catch(e) {
          print('catch(e): ${e.toString()}');
          showSnackBar(message: otpNumberIsNotCorrect.tr);
        }
      });

      statusRequest = StatusRequest.success;
      update();
    } else {
      showSnackBar(message: otpNumberExpired.tr);
    }
  }

  @override
  resendOTP() async {
    final phoneNumber = '${Get.arguments['phoneNumber']}';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {

      },
      verificationFailed: (FirebaseAuthException e) {
        if(e.toString().contains('too-many-requests')) {
          showSnackBar(message: blockedAllRequests.tr);
        }
        print('verificationFailed ${e.toString()}');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('codeSent $verificationId || $resendToken');
        if(timer != null) {
          timer!.cancel();
          start = 60;
        }
        startCounter();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('codeAutoRetrievalTimeout $verificationId');
      },
    );
  }

  @override
  startCounter() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          timer.cancel();
          update();
        } else {
          start--;
          update();
        }
      },
    );
  }

  @override
  void onInit() {
    startCounter();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

}