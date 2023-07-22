import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opencarssooq/data/models/rated_store.dart';
import 'package:opencarssooq/data/models/store.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../data/models/store_rating.dart';
import '../custom_text.dart';
import '../rounded_image.dart';
import '../rounded_image2.dart';
import 'custom_rating_card_home.dart';

class CustomCardStore extends StatelessWidget {
  final RatedStore store;
  final GestureTapCallback? onTap;
  const CustomCardStore({Key? key, required this.store, this.onTap}) : super(key: key);

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
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                RoundedImage2(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  width: 120,
                  height: 115,
                  imagePath: store.logo!,
                ),
                CustomRatingCardHome(rate: store.rate!),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomText(
                text: store.name!,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
