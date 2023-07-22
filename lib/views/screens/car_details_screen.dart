import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/car_controller.dart';
import 'package:opencarssooq/core/functions/encode_decode_image64.dart';
import 'package:opencarssooq/data/models/store.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';
import 'package:opencarssooq/views/widgets/rounded_image.dart';

import '../../controllers/favorite_cars_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/constant/app_route.dart';
import '../../core/functions/call_phone.dart';
import '../../core/localization/text_language_keys.dart';
import '../../data/models/car.dart';
import '../widgets/car/images_dots.dart';
import '../widgets/car/images_slider.dart';
import '../widgets/custom_button.dart';
import '../widgets/home/custom_rating_card_home.dart';
import '../widgets/rounded_image2.dart';

class CarDetailsScreen extends StatelessWidget {
  CarDetailsScreen({Key? key}) : super(key: key);

  CarControllerImp controllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgSettingsColor,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 310.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.bgSettingsColor,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(AppImageAsset.back),
                ),
                actions: [
                  GetBuilder<CarControllerImp>(builder: (controllerImp) {
                    return IconButton(
                      onPressed: () => controllerImp.clickHeart(),
                      icon: SvgPicture.asset(controllerImp.heartIcon),
                    );
                  }),
                  Visibility(
                    visible: controllerImp.isVendor,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.editCarScreen);
                        controllerImp.getCarData(controllerImp.car!);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      ImagesSlider(
                        controller: controllerImp.imagesController,
                        currentIndex: controllerImp.currentImageIndex,
                        images: controllerImp.car!.images!,
                        onPageChanged: (index, reason) {
                          controllerImp.changeImageIndex(index);
                        },
                      ),
                      GetBuilder<CarControllerImp>(builder: (controllerImp) {
                        return ImagesDots(
                          images: controllerImp.car!.images!,
                          currentIndex: controllerImp.currentImageIndex,
                          controller: controllerImp.imagesController,
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
            child: Stack(
              children: [
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 120),
                  children: [
                    GestureDetector(
                      onTap:() => Get.toNamed(AppRoute.storeDetailsScreen, arguments: {'storeId' : controllerImp.car!.storeId}),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedImage2(
                          height: 60,
                          width: 60,
                          borderRadius: BorderRadius.circular(100),
                          imagePath: controllerImp.store!.logo!,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          text: controllerImp.store!.name!,
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
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
                    CustomText(
                      text: controllerImp.car!.name!,
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    CustomText(
                      text: '\$${controllerImp.car!.price!}',
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text: controllerImp.car!.description!,
                      color: AppColors.grayColor,
                      maxLines: null,
                      fontSize: 14,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 24),
                    decoration: const BoxDecoration(
                        color: AppColors.bgSettingsColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: CustomButton(
                      onPressed: () => callPhone(controllerImp.store!.phone!),
                      text: callTheStore.tr,
                      shape: 20,
                      width: double.infinity,
                      height: 60,
                      textSize: 18,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
