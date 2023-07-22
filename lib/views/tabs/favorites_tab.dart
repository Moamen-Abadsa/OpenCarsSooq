import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/favorite_cars_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';

import '../../core/class/grid_fixed_items_height.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_route.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/custom_text.dart';
import '../widgets/home/custom_card_car.dart';

class FavoritesTab extends StatelessWidget {
  FavoritesTab({Key? key}) : super(key: key);

  FavoriteCarControllerImp c = Get.find();

  @override
  Widget build(BuildContext context) {
    c.getUserFavorite();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<FavoriteCarControllerImp>(
        builder: (controllerImp) {
          return HandlingDataView(
            statusRequest: controllerImp.statusRequest,
            widget: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: favorites.tr,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                controllerImp.carsList.isEmpty
                    ? Expanded(
                        child: Image.asset(
                          AppImageAsset.favorites,
                          width: 250,
                          height: 250,
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  height: 230),
                          itemBuilder: (context, index) {
                            return CustomCardCar(
                              car: controllerImp.carsList[index].car,
                              storeName:
                                  controllerImp.carsList[index].store.name!,
                              isVendor: false,
                              onTap: () => Get.toNamed(
                                  AppRoute.carDetailsScreen,
                                  arguments: {
                                    'car': controllerImp.carsList[index].car,
                                    'store': controllerImp.carsList[index].store
                                  }),
                              onTapFav: () => controllerImp.clickHeart(
                                  controllerImp.carsList[index].car, index),
                            );
                          },
                          itemCount: controllerImp.carsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
