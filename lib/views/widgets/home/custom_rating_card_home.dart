import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../custom_text.dart';

class CustomRatingCardHome extends StatelessWidget {
  final Color bgColor;
  final double rateFontSize;
  final double containerVerticalPadding;
  final double containerHorizontalPadding;
  final double containerWidth;
  final double rate;

  const CustomRatingCardHome(
      {Key? key,
      this.rate = 0,
      this.bgColor = Colors.white,
      this.rateFontSize = 12,
      this.containerWidth = 50,
      this.containerVerticalPadding = 4,
      this.containerHorizontalPadding = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(14)),
      padding: EdgeInsets.symmetric(
          vertical: containerVerticalPadding,
          horizontal: containerHorizontalPadding),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: '$rate',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 4,
          ),
          SvgPicture.asset(
            AppImageAsset.star,
            width: 13,
            height: 13,
          ),
        ],
      ),
    );
  }
}
