import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/car_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/functions/valid_inputs.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/add_car/custom_text_form.dart';
import '../widgets/auth/circle_image_auth.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/auth/custom_text_form_auth.dart';
import '../widgets/custom_app_bar.dart';

class EditCarScreen extends StatelessWidget {
  const EditCarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<CarControllerImp>(
          builder: (controllerImp) {
            return HandlingDataView(
              statusRequest: controllerImp.statusRequest,
              widget: Form(
                key: controllerImp.carController,
                child: ListView(
                  children: [
                    CustomAppBar(
                      title: updateCar.tr,
                    ),

                    SizedBox(
                      height: 18,
                      width: Get.width,
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: CircleImageAuth(
                        onTap: () => controllerImp.pickImage(),
                        selectedImage: controllerImp.carImages.isNotEmpty ? controllerImp.carImages[0] : null,
                        base64Logo: controllerImp.carImages64.isNotEmpty ? controllerImp.carImages64[0] : null,
                      ),
                    ),

                    CustomTextForm(
                      controller: controllerImp.tecName,
                      valid: (value) {
                        return validInput(value!, 5, 100, "name");
                      },
                      keyboardType: TextInputType.name,
                      hintText: enterCarName.tr,
                      labelText: name.tr,
                      margin: const EdgeInsets.only(
                          bottom: 24, top: 33, left: 24, right: 24),
                    ),
                    CustomTextForm(
                      controller: controllerImp.tecPrice,
                      valid: (value) {
                        return validInput(value!, 2, 10, "price");
                      },
                      keyboardType: TextInputType.number,
                      hintText: enterCarPrice.tr,
                      labelText: price.tr,
                      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                    ),
                    CustomTextForm(
                      controller: controllerImp.tecDescription,
                      valid: (value) {
                        return validInput(value!, 5, 100, "description");
                      },
                      keyboardType: TextInputType.multiline,
                      hintText: enterCarDescription.tr,
                      labelText: description.tr,
                      margin: const EdgeInsets.only(bottom: 8, left: 24, right: 24),
                    ),
                    CustomButtonAuth(
                      text: Update.tr,
                      onPressed: () => controllerImp.updateCar(),
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
