import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/reset_password_cotroller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/localization/text_language_keys.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/app_route.dart';
import '../../../core/functions/valid_inputs.dart';
import '../../widgets/auth/custom_button_auth.dart';
import '../../widgets/auth/custom_text_form_auth.dart';
import '../../widgets/auth/custom_text_sign_up_or_sign_in.dart';
import '../../widgets/custom_text.dart';
import 'custom_app_bar.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  const ConfirmPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ResetPasswordControllerImp>(
          builder: (controllerImp) {
            return HandlingDataRequest(
              statusRequest: controllerImp.statusRequest,
              widget: Form(
                key: controllerImp.resetPasswordControllerImp,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomAppBar(
                            title: confirmPassword.tr,
                            sizeSpace: 110,
                            paddingTop: 25,
                          ),
                          SizedBox(
                            height: 40,
                            width: Get.width,
                          ),
                          CustomText(
                            text: confirmPassword.tr,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          CustomText(
                            text:
                            pleaseEnterYourNewPassword.tr,
                            fontSize: 14,
                            maxLines: 2,
                            color: AppColors.grayColor,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextFormAuth(
                                    controller: controllerImp.tecNewPassword,
                                    valid: (value) {
                                      return validInput(value!, 5, 100, "password");
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: enterNewPassword.tr,
                                    labelText: password.tr,
                                    icon: AppImageAsset.lock,
                                    margin: const EdgeInsets.only(
                                        bottom: 24, left: 24, right: 24),
                                  ),
                                  CustomTextFormAuth(
                                    controller: controllerImp.tecReNewPassword,
                                    valid: (value) {
                                      return validInput(value!, 5, 30, "password");
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: re_enterNewPassword.tr,
                                    labelText: confirmPassword.tr,
                                    icon: AppImageAsset.lock,
                                    margin: const EdgeInsets.only(bottom: 14, left: 24, right: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomButtonAuth(
                            text: Continue.tr,
                            onPressed: () => controllerImp.saveNewPassword(),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
