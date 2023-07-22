import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/forgot_password_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/app_route.dart';
import '../../../core/functions/valid_inputs.dart';
import '../../../core/localization/text_language_keys.dart';
import '../../widgets/auth/custom_button_auth.dart';
import '../../widgets/auth/custom_text_form_auth.dart';
import '../../widgets/auth/custom_text_sign_up_or_sign_in.dart';
import '../../widgets/custom_text.dart';
import 'custom_app_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
             hasScrollBody: false,
              child: GetBuilder<ForgotPasswordControllerImp>(
                builder: (controllerImp) {
                  return HandlingDataRequest(
                    statusRequest: controllerImp.statusRequest,
                    widget: Form(
                      key: controllerImp.forgotPasswordController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomAppBar(
                            title: forgetPassword.tr,
                            sizeSpace: 110,
                            paddingTop: 25,
                          ),
                          SizedBox(
                            height: 40,
                            width: Get.width,
                          ),
                          CustomText(
                            text: forgetPassword.tr,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          CustomText(
                            text: titleForgotPassword.tr,
                            fontSize: 14,
                            maxLines: 2,
                            color: AppColors.grayColor,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomTextFormAuth(
                                controller: controllerImp.tecEmail,
                                valid: (value) {
                                  return validInput(value!, 5, 100, "email");
                                },
                                keyboardType: TextInputType.emailAddress,
                                hintText: enterYourEmail.tr,
                                labelText: email.tr,
                                icon: AppImageAsset.email,
                                margin: const EdgeInsets.only(
                                    bottom: 24, left: 24, right: 24),
                              ),
                            ),
                          ),
                          CustomButtonAuth(
                            text: Continue.tr,
                            onPressed: () => controllerImp.getUserData(),
                            margin:
                            const EdgeInsets.only(bottom: 100, left: 24, right: 24),
                          ),
                          CustomTextSignUpOrSignIn(
                            onTap: () => Get.toNamed(AppRoute.signUpScreen),
                            textOne: dontHaveAccount.tr,
                            textTow: signUp.tr,
                          ),
                          const SizedBox(
                            height: 47,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
