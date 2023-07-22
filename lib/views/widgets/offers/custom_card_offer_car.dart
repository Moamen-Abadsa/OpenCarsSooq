import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/data/models/products_data.dart';
import 'package:opencarssooq/views/widgets/offers/custom_offer_details.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/localization/text_language_keys.dart';
import '../custom_text.dart';
import '../rounded_image.dart';
import '../rounded_image2.dart';

class CustomCardOfferCar extends StatelessWidget {
  final ProductsData productsData;
  const CustomCardOfferCar({Key? key, required this.productsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(CustomOfferDetails(productsData: productsData,));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          color: AppColors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  RoundedImage2(
                    width: 120,
                    height: 100,
                    imagePath: productsData.car.images![0],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: productsData.car.name!,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: '\$${productsData.car.price}',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayColor,
                            textAlign: TextAlign.left,
                            decoration: TextDecoration.lineThrough,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: "\$${productsData.car.newPrice}",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: CustomText(
                    text: '${productsData.car.percent}% ${off.tr}',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
