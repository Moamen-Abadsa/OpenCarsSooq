import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../custom_text.dart';

class CustomSettingsRow extends StatelessWidget {
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final String title;
  final String iconPath;

  const CustomSettingsRow(
      {Key? key,
      this.onTap,
      this.margin,
      required this.title,
      required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            color: AppColors.bgSettingsColor,
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            SvgPicture.asset(
              AppImageAsset.arrow,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
