import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/class/status_request.dart';
import 'package:opencarssooq/views/widgets/rounded_image.dart';

import '../../core/class/grid_fixed_items_height.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/constant/app_route.dart';
import '../../core/functions/open_whatsapp.dart';
import '../../core/functions/store_states.dart';
import '../../core/localization/text_language_keys.dart';
import '../../data/models/car.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/home/custom_card_car.dart';
import '../widgets/home/custom_rating_card_home.dart';
import '../widgets/rounded_image2.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<StoreControllerImp>(
          builder: (controllerImp) {
            return HandlingDataView(
              statusRequest: controllerImp.statusRequest,
              widget: Stack(
                children: [
                  controllerImp.store != null
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () => Get.back(),
                                            icon: SvgPicture.asset(
                                                AppImageAsset.back),
                                            iconSize: 24),
                                        const Spacer(),
                                        CustomRatingCardHome(
                                          bgColor: AppColors.bgSettingsColor,
                                          rateFontSize: 14,
                                          containerHorizontalPadding: 6,
                                          containerVerticalPadding: 6,
                                          containerWidth: 60,
                                          rate: controllerImp.storeRate,
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: RoundedImage2(
                                          width: 150,
                                          height: 150,
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          imagePath: controllerImp.store!.logo!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: controllerImp.store!.name!,
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CustomText(
                                  text:
                                      '${controllerImp.store!.address!} - ${states[controllerImp.store!.state!].name}',
                                  fontSize: 12,
                                  color: AppColors.grayColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                CustomText(
                                  text: controllerImp.store!.phone!,
                                  fontSize: 12,
                                  color: AppColors.grayColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  color: AppColors.grayDividerColor,
                                  height: 1,
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                    text: cars.tr,
                                    fontSize: 24,
                                    textAlign: TextAlign.start,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                HandlingDataView(
                                  statusRequest:
                                      controllerImp.carsStatusRequest,
                                  widget: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6,
                                            height: controllerImp.isVendor
                                                ? 277
                                                : 230),
                                    itemBuilder: (context, index) {
                                      Car car = controllerImp.storeCars[index];
                                      return CustomCardCar(
                                        car: car,
                                        storeName: controllerImp.store!.name!,
                                        isVendor: controllerImp.isVendor,
                                        onTap: () {
                                          Get.toNamed(AppRoute.carDetailsScreen,
                                              arguments: {
                                                'car': car,
                                                'store': controllerImp.store,
                                              });
                                        },
                                        onTapFav: () {
                                          controllerImp.clickHeart(car);
                                        },
                                        onTapEditCar: () {
                                          controllerImp.goToEditCarStore(car, index);
                                        },
                                        onTapAddOffer: () {
                                          car.hasOffer
                                              ? controllerImp
                                                  .goToEditCarOffer(car)
                                              : controllerImp
                                                  .goToAddCarOffer(car);
                                        },
                                        onTapDeleteCar: () {
                                          controllerImp.deleteCarStore(
                                              car.id!, index);
                                        },
                                        onTapDeleteCarOffer: () {
                                          controllerImp.deleteCarOffer(car);
                                        },
                                      );
                                    },
                                    itemCount: controllerImp.storeCars.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      decoration: const BoxDecoration(
                          color: AppColors.bgSettingsColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !controllerImp.isVendor,
                            child: CustomButton(
                              text: rateStore.tr,
                              onPressed: () {
                                controllerImp.goToRateStore();
                              },
                            ),
                          ),
                          Visibility(
                            visible: controllerImp.isVendor,
                            child: GestureDetector(
                              child: SvgPicture.asset(
                                AppImageAsset.add,
                                width: 40,
                                height: 40,
                              ),
                              onTap: () => controllerImp.goToAddCar(),
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Visibility(
                            visible: controllerImp.isVendor,
                            child: GestureDetector(
                              child: SvgPicture.asset(
                                AppImageAsset.edit,
                                width: 40,
                                height: 40,
                              ),
                              onTap: () => controllerImp.goToEditStore(),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            child: SvgPicture.asset(AppImageAsset.facebook),
                            onTap: () => controllerImp
                                .openLink(controllerImp.store!.fbLink!),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(AppImageAsset.insta),
                            onTap: () => controllerImp
                                .openLink(controllerImp.store!.instaLink!),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(AppImageAsset.whatsapp),
                            onTap: () => openWhatsapp(number: controllerImp.store!.wtLink!, text: 'Hi!'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
