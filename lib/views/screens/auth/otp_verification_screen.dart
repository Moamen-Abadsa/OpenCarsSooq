import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';

import '../../../controllers/otp_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_route.dart';
import '../../../core/localization/text_language_keys.dart';
import '../../widgets/auth/custom_button_auth.dart';
import '../../widgets/auth/custom_text_timer_otp.dart';
import '../../widgets/auth/texst_underline_auth.dart';
import '../../widgets/custom_text.dart';
import 'custom_app_bar.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OtpControllerImp>(
          builder: (controllerImp) {
            return HandlingDataRequest(
              statusRequest: controllerImp.statusRequest,
              widget: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomAppBar(
                          title: otpVerification.tr,
                          sizeSpace: 110,
                          paddingTop: 25,
                        ),
                        SizedBox(
                          height: 40,
                          width: Get.width,
                        ),
                        CustomText(
                          text: otpVerification.tr,
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: AppColors.black,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        CustomTextTimerOTP(
                          textTitle:
                          weSentYourCodeTo.tr + '${Get.arguments['phoneNumber']} \n'+ thisCodeWillExpiredIn.tr,
                          textTimer: '00:${controllerImp.start}',
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: OtpTextField(
                              fieldWidth: 45,
                              borderRadius: BorderRadius.circular(15),
                              numberOfFields: 6,
                              borderWidth: 1,
                              enabledBorderColor: AppColors.grayColor,
                              borderColor: AppColors.grayColor,
                              showFieldAsBox: true,
                              margin: const EdgeInsets.only(right: 10.0),
                              onCodeChanged: (String code) {},
                              onSubmit: (String verificationCode) {
                                controllerImp.checkOtp(verificationCode);
                              }, // end onSubmit
                            ),
                          ),
                        ),
                        /*CustomButtonAuth(
                      text: 'Continue',
                      onPressed: () {},
                      margin:
                          const EdgeInsets.only(bottom: 100, left: 24, right: 24),
                    ),*/
                        TextUnderlineAuth(
                          text: resendOtpCode.tr,
                          color: AppColors.grayColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          alignment: Alignment.center,
                          marginBottom: 47,
                          onTap: () => controllerImp.resendOTP(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
