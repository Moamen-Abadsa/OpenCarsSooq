import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/call_phone.dart';
import 'package:opencarssooq/data/models/products_data.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/localization/text_language_keys.dart';
import '../custom_button.dart';
import '../custom_text.dart';
import '../rounded_image.dart';
import '../rounded_image2.dart';

class CustomOfferDetails extends StatelessWidget {
  final ProductsData productsData;
  const CustomOfferDetails({Key? key, required this.productsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18)),
          color: Colors.white
        ),
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: RoundedImage2(
                width: 250,
                height: 180,
                borderRadius: BorderRadius.circular(8),
                imagePath: productsData.car.images![0],
              ),
            ),
            SizedBox(height: 20,),
            CustomText(
              text: productsData.car.name!,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              textAlign: TextAlign.start,
            ),
            CustomText(
              text: productsData.store.name!,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 6,),
            Row(
              children: [
                CustomText(
                  text: '\$${productsData.car.price}',
                  fontSize: 24,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            CustomText(
              text: '${productsData.car.percent}% ${off.tr}',
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 6,),
            CustomText(
              text: productsData.car.description!,
              color: AppColors.grayColor,
              maxLines: 3,
              fontSize: 14,
              textAlign: TextAlign.start,
            ),
            CustomButton(
              onPressed: () {
                callPhone(productsData.store.phone!);
              },
              text: callTheStore.tr,
              shape: 15,
              width: double.infinity,
              height: 50,
              textSize: 18,
              margin: EdgeInsets.only(left: 50, right: 50, top: 30),
            )
          ],
        ),
      ),
    );
  }
}
