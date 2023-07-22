import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../controllers/search_controller.dart';
import '../../core/class/grid_fixed_items_height.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/constant/app_route.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/home/custom_card_car.dart';
import '../widgets/offers/custom_text_form_search.dart';

class SearchTab extends StatelessWidget {
  SearchTab({Key? key}) : super(key: key);

  SearchControllerImp controllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextFormSearch(
                  controller: controllerImp.tecSearch,
                  keyboardType: TextInputType.text,
                  hintText: searchCars.tr,
                  icon: AppImageAsset.search,
                  margin: const EdgeInsets.only(right: 12),
                  onFieldSubmitted: (value) {
                    controllerImp.startSearch(value.trim());
                  },
                ),
              ),
              GestureDetector(
                onTap: () => controllerImp.fiterResult(),
                child: SvgPicture.asset(AppImageAsset.filter),
              ),
            ],
          ),
          Expanded(
            child: GetBuilder<SearchControllerImp>(builder: (controllerImp) {
            return HandlingDataView(
              statusRequest: controllerImp.statusRequest,
              widget: controllerImp.carsList.isEmpty ? 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImageAsset.searchTab,
                  width: 195,
                  height: 195,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                  child: CustomText(
                    text: titleSearchCars.tr,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ) : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  height: 230),
              itemBuilder: (context, index) {
                    return CustomCardCar(
                      car: controllerImp.carsList[index].car,
                      storeName: controllerImp.carsList[index].store.name!,
                      isVendor: false,
                      onTap: () => Get.toNamed(AppRoute.carDetailsScreen,
                          arguments: {
                            'car': controllerImp.carsList[index].car,
                            'store': controllerImp.carsList[index].store
                          }),
                      onTapFav: () => controllerImp.clickHeart(controllerImp.carsList[index].car),
                    );
              },
              itemCount: controllerImp.carsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 20),
            ),
            );
          },
          ),
          
          ),
        ],
      ),
    );
  }
}
