import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/login_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/core/constant/app_route.dart';

import '../../../core/functions/valid_inputs.dart';
import '../../../core/localization/text_language_keys.dart';
import '../../widgets/auth/check_box.dart';
import '../../widgets/auth/custom_button_auth.dart';
import '../../widgets/auth/custom_text_form_auth.dart';
import '../../widgets/auth/custom_text_sign_up_or_sign_in.dart';
import '../../widgets/auth/texst_underline_auth.dart';
import '../../widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    width: Get.width,
                  ),
                  CustomText(
                    text: signIn.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 55,
                    width: Get.width,
                  ),
                  CustomText(
                    text: welcomeBack.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: AppColors.black,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  CustomText(
                    text: signInWithYourEmailAndPassword.tr,
                    fontSize: 14,
                    color: AppColors.grayColor,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GetBuilder<LoginControllerImp>(
                        builder: (controllerImp) {
                          return HandlingDataRequest(
                            statusRequest: controllerImp.statusRequest,
                            widget: Form(
                              key: controllerImp.loginFormState,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextFormAuth(
                                    controller: controllerImp.tecEmail,
                                    valid: (value) {
                                      return validInput(value!, 5, 100, "email");
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: enterYourEmail.tr,
                                    labelText: email.tr,
                                    icon: AppImageAsset.email,
                                    margin: const EdgeInsets.only(bottom: 24),
                                  ),
                                  CustomTextFormAuth(
                                    controller: controllerImp.tecPassword,
                                    valid: (value) {
                                      return validInput(
                                          value!, 5, 30, "password");
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: enterYourPassword.tr,
                                    labelText: password.tr,
                                    icon: AppImageAsset.lock,
                                    margin: const EdgeInsets.only(bottom: 24),
                                  ),
                                  Row(
                                    children: [
                                      LabeledCheckbox(
                                        label: rememberMe.tr,
                                        onChanged: (newValue) {
                                          controllerImp
                                              .checkRememberMer(newValue);
                                        },
                                        value: controllerImp.checkedValue,
                                      ),
                                      const Spacer(),
                                      TextUnderlineAuth(
                                        text: forgetPassword.tr,
                                        color: AppColors.grayColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        marginRight: 4,
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoute.forgotPasswordScreen);
                                        },
                                      ),
                                    ],
                                  ),
                                  CustomButtonAuth(
                                    text: signIn.tr,
                                    onPressed: () {
                                      controllerImp.login();
                                    },
                                    margin: const EdgeInsets.only(top: 32),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  CustomTextSignUpOrSignIn(
                    onTap: () => Get.toNamed(AppRoute.signUpScreen),
                    textOne: dontHaveAccount.tr,
                    textTow: signUp.tr,
                  ),
                  SizedBox(
                    height: 86,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
