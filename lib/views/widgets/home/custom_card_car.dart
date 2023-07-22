import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/data/models/car.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/app_route.dart';
import '../../../core/localization/text_language_keys.dart';
import '../custom_text.dart';
import '../rounded_image.dart';
import '../rounded_image2.dart';

class CustomCardCar extends StatelessWidget {
  final Car car;
  final String storeName;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapFav;
  final GestureTapCallback? onTapAddOffer;
  final GestureTapCallback? onTapEditCar;
  final GestureTapCallback? onTapDeleteCar;
  final GestureTapCallback? onTapDeleteCarOffer;
  final bool isVendor;

  CustomCardCar(
      {Key? key,
      required this.car,
      required this.storeName,
      required this.isVendor,
      this.onTap,
      this.onTapFav,
      this.onTapAddOffer,
      this.onTapEditCar,
      this.onTapDeleteCar,
      this.onTapDeleteCarOffer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                RoundedImage2(imagePath: car.images![0]),
                GestureDetector(
                  onTap: onTapFav,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(40)),
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      !car.isFav
                          ? AppImageAsset.heart
                          : AppImageAsset.heartFill,
                      width: 16,
                      height: 16,
                      color: !car.isFav ? AppColors.white : AppColors.redHeart,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
              child: CustomText(
                text: car.name!,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              child: CustomText(
                text: car.description!,
                fontSize: 14,
                maxLines: 2,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomText(
                      text: storeName,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomText(
                      text: '${car.price!}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isVendor,
              child: PopupMenuButton(
                padding: EdgeInsets.only(left: 6, right: 8, top: 6),
                icon: SvgPicture.asset(
                  AppImageAsset.menu,
                  width: 20,
                  height: 20,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      onTap: onTapAddOffer,
                      child: ListTile(
                        leading: Icon(
                          car.hasOffer ? Icons.edit : Icons.add,
                          color: car.hasOffer ? Colors.amber : Colors.green,
                        ),
                        title: Text(
                            car.hasOffer ? editCarOffer.tr : addCarOffer.tr),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onTapEditCar,
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Colors.amber,
                        ),
                        title: Text(editCar.tr),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onTapDeleteCar,
                      child: ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: Text(deleteCar.tr),
                      ),
                    ),
                    if (car.hasOffer)
                      PopupMenuItem(
                        onTap: onTapDeleteCarOffer,
                        child: ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          title: Text(deleteCarOffer.tr),
                        ),
                      ),
                  ];
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
