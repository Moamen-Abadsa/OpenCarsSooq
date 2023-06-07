import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/signup_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/class/status_request.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/views/screens/auth/sign_up_store_screen.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/functions/valid_inputs.dart';
import '../../widgets/auth/check_box.dart';
import '../../widgets/auth/custom_button_auth.dart';
import '../../widgets/auth/custom_text_form_auth.dart';
import '../../widgets/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SignUpControllerImp>(
          builder: (controllerImp) {
            return HandlingDataRequest(
              statusRequest: controllerImp.statusRequest,
              widget: Form(
                key: controllerImp.signUpController,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                      width: Get.width,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: SvgPicture.asset(AppImageAsset.back)),
                        ),
                        Container(
                          width: Get.width - 120,
                          child: CustomText(
                            text: 'Sign Up',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      width: Get.width,
                    ),
                    CustomText(
                      text: 'Register Account',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    CustomText(
                      text: 'Sign up with your Info',
                      fontSize: 14,
                      color: AppColors.grayColor,
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecName,
                      valid: (value) {
                        return validInput(value!, 5, 100, "name");
                      },
                      keyboardType: TextInputType.name,
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      icon: AppImageAsset.person,
                      margin: const EdgeInsets.only(
                          bottom: 24, top: 33, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecEmail,
                      valid: (value) {
                        return validInput(value!, 5, 100, "email");
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      icon: AppImageAsset.email,
                      margin: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecPhone,
                      valid: (value) {
                        return validInput(value!, 10, 10, "phone");
                      },
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter your phone number',
                      labelText: 'Phone',
                      icon: AppImageAsset.phone,
                      margin: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecAddress,
                      valid: (value) {
                        return validInput(value!, 5, 100, "address");
                      },
                      keyboardType: TextInputType.text,
                      hintText: 'Enter your address',
                      labelText: 'Address',
                      icon: AppImageAsset.location,
                      margin: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecPassword,
                      valid: (value) {
                        return validInput(value!, 5, 30, "password");
                      },
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      icon: AppImageAsset.lock,
                      margin: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecRePassword,
                      valid: (value) {
                        return validInput(value!, 5, 30, "password");
                      },
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Re-enter your password',
                      labelText: 'Confirm Password',
                      icon: AppImageAsset.lock,
                      margin: const EdgeInsets.only(
                          bottom: 14, left: 24, right: 24),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                      child: LabeledCheckbox(
                        label: "I'm a vendor",
                        onChanged: (newValue) {
                          controllerImp.checkVendor(newValue);
                        },
                        value: controllerImp.isVendor,
                      ),
                    ),
                    CustomButtonAuth(
                      text: controllerImp.titleButton,
                      onPressed: () => controllerImp.saveUser(),
                      margin: const EdgeInsets.all(24),
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
