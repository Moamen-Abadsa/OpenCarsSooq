import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';

import '../../controllers/car_offer_controller.dart';
import '../../core/class/handling_data_view.dart';
import '../../core/constant/app_color.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/custom_text.dart';
import '../widgets/offers/custom_card_offer_car.dart';
import '../widgets/offers/custom_text_form_search.dart';

class OffersTab extends StatelessWidget {
  OffersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<CarOfferControllerImp>(
        builder: (controllerImp) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                child: CustomText(
                  text: offers.tr,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextFormSearch(
                controller: controllerImp.tecSearch,
                keyboardType: TextInputType.text,
                hintText: searchCars.tr,
                icon: AppImageAsset.search,
                margin: const EdgeInsets.only(right: 12),
                onChanged: (value) => controllerImp.onFieldSubmitted(value),
              ),
              Expanded(
                child: HandlingDataView(
                  statusRequest: controllerImp.statusRequest,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controllerImp.offerList.length,
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) {
                      return CustomCardOfferCar(
                        productsData: controllerImp.offerList[index],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
