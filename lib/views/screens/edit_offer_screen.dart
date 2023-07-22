import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/car_offer_controller.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../core/class/handling_data_view.dart';
import '../../core/functions/valid_inputs.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/add_car/custom_row.dart';
import '../widgets/add_car/custom_text_form.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/custom_app_bar.dart';

class EditOfferScreen extends StatelessWidget {
  EditOfferScreen({Key? key}) : super(key: key);

  // CarOfferControllerImp c = Get.find();

  @override
  Widget build(BuildContext context) {
    // c.getCarData();

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<CarOfferControllerImp>(
          builder: (controllerImp) {
            return HandlingDataView(
              statusRequest: controllerImp.statusRequest,
              widget: Form(
                key: controllerImp.carOfferController,
                child: ListView(
                  children: [
                    CustomAppBar(
                      title: updateOffer.tr,
                    ),
                    SizedBox(
                      height: 18,
                      width: Get.width,
                    ),
                    Image.asset(AppImageAsset.offer, height: 250,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                      child: CustomText(
                        text: controllerImp.car!.name!,
                        color: AppColors.black,
                        textAlign: TextAlign.start,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomText(
                        text: controllerImp.car!.description!,
                        textAlign: TextAlign.start,
                        fontSize: 18,
                        maxLines: 3,
                      ),
                    ),
                    CustomRow(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      title: oldPrice.tr,
                      body: '\$${controllerImp.car!.price!}',
                    ),
                    CustomTextForm(
                      controller: controllerImp.tecNewPrice,
                      valid: (value) {
                        return validInput(value!, 2, 10, "price");
                      },
                      onChanged: (String text) {
                        controllerImp.onChangeText(text);
                      },
                      keyboardType: TextInputType.number,
                      hintText: enterCarNewPrice.tr,
                      labelText: newPrice.tr,
                      margin: const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 20),
                    ),
                    CustomRow(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      title: discountPercentage.tr,
                      body: '%${controllerImp.percent}',
                    ),
                    CustomButtonAuth(
                      text: Update.tr,
                      onPressed: () => controllerImp.updateOffer(),
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
