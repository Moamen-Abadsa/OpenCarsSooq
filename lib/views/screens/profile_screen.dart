import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/signup_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/functions/valid_inputs.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/auth/custom_text_form_auth.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                    CustomAppBar(
                      title: profile.tr,
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecName,
                      valid: (value) {
                        return validInput(value!, 5, 100, "name");
                      },
                      keyboardType: TextInputType.name,
                      hintText: enterNewName.tr,
                      labelText: name.tr,
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
                      hintText: enterNewEmail.tr,
                      labelText: email.tr,
                      icon: AppImageAsset.email,
                      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecPhone,
                      valid: (value) {
                        return validInput(value!, 10, 10, "phone");
                      },
                      keyboardType: TextInputType.phone,
                      hintText: enterNewPhoneNumber.tr,
                      labelText: phone.tr,
                      icon: AppImageAsset.phone,
                      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextFormAuth(
                      controller: controllerImp.tecAddress,
                      valid: (value) {
                        return validInput(value!, 5, 100, "address");
                      },
                      keyboardType: TextInputType.text,
                      hintText: enterNewAddress.tr,
                      labelText: address.tr,
                      icon: AppImageAsset.location,
                      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    ),
                    CustomButtonAuth(
                      text: saveChanges.tr,
                      onPressed: () => controllerImp.updateUserData(),
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
