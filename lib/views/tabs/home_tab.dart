import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/home_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../core/class/grid_fixed_items_height.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/home/card_store.dart';
import '../widgets/home/custom_card_car.dart';
import '../widgets/home/list_row.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<HomeControllerImp>(
        builder: (controllerImp) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '${hi.tr} ${controllerImp.userName}!',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Image.asset(
                  AppImageAsset.banner,
                  width: double.infinity,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: ListRow(
                  textOne: bestSeller.tr,
                  textTow: '',
                ),
              ),
              SliverToBoxAdapter(
                child: HandlingDataView(
                  statusRequest: controllerImp.storesStatusRequest,
                  widget: Container(
                    height: 160,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controllerImp.storesList.length,
                      itemBuilder: (context, index) {
                        return CustomCardStore(
                          store: controllerImp.storesList[index],
                          onTap: () {
                            Get.toNamed(AppRoute.storeDetailsScreen,
                                arguments: {
                                  'storeId': controllerImp.storesList[index].id
                                });
                          }
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListRow(
                  textOne: newCars.tr,
                  textTow: '',
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              HandlingDataViewHome(
                statusRequest: controllerImp.carsStatusRequest,
                widget: SliverGrid.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
