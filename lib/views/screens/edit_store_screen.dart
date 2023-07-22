import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/signup_store_controller.dart';
import '../../core/class/handling_data_view.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/functions/store_states.dart';
import '../../core/functions/valid_inputs.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/auth/circle_image_auth.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/auth/custom_spinner.dart';
import '../widgets/auth/custom_text_form_auth.dart';
import '../widgets/custom_text.dart';

class EditStoreScreen extends StatelessWidget {
  const EditStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SignUpStoreControllerImp>(builder: (controllerImp) {
          return HandlingDataRequest(
            statusRequest: controllerImp.statusRequest,
            widget: Form(
              key: controllerImp.signUpStoreController,
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
                          text: updateStore.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleImageAuth(
                      onTap: () => controllerImp.pickImage(),
                      selectedImage: controllerImp.logo,
                      base64Logo: controllerImp.base64Logo,
                    ),
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.tecName,
                    valid: (value) {
                      return validInput(value!, 5, 100, "name");
                    },
                    keyboardType: TextInputType.name,
                    hintText: enterStoreName.tr,
                    labelText: name.tr,
                    icon: AppImageAsset.storeName,
                    margin: const EdgeInsets.only(
                        bottom: 24, top: 33, left: 24, right: 24),
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.tecPhone,
                    valid: (value) {
                      return validInput(value!, 10, 10, "phone");
                    },
                    keyboardType: TextInputType.phone,
                    hintText: enterStorePhoneNumber.tr,
                    labelText: phone.tr,
                    icon: AppImageAsset.phone,
                    margin:
                    const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.tecAddress,
                    valid: (value) {
                      return validInput(value!, 5, 100, "address");
                    },
                    keyboardType: TextInputType.text,
                    hintText: enterStoreAddress.tr,
                    labelText: address.tr,
                    icon: AppImageAsset.location,
                    margin:
                    const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  ),
                  CustomLabeledSpinner(
                    label: state.tr,
                    hint: state.tr,
                    requiredValue: thisFieldIsRequired.tr,
                    margin:
                    const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    selectedValue: controllerImp.selectedState,
                    items: states.map((typeCom) {
                      return DropdownMenuItem(
                        value: typeCom,
                        child: Text(typeCom.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controllerImp.selectDropDownItems(value);
                    },
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.fbLink,
                    keyboardType: TextInputType.text,
                    hintText: enterStoreFacebookUrl.tr,
                    labelText: facebook.tr,
                    icon: AppImageAsset.facebookGray,
                    margin:
                    const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.instaLink,
                    keyboardType: TextInputType.text,
                    hintText: enterStoreInstegramUrl.tr,
                    labelText: instegram.tr,
                    icon: AppImageAsset.instaGray,
                    margin:
                    const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  ),
                  CustomTextFormAuth(
                    controller: controllerImp.wtLink,
                    keyboardType: TextInputType.text,
                    hintText: enterStoreWhatsappUrl.tr,
                    labelText: whatsapp.tr,
                    icon: AppImageAsset.whatsappGray,
                    margin:
                    const EdgeInsets.only(bottom: 10, left: 24, right: 24),
                  ),
                  CustomButtonAuth(
                    text: Update.tr,
                    onPressed: () => controllerImp.updateStore(),
                    margin: const EdgeInsets.all(24),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
