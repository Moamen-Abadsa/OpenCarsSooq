import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_image_asset.dart';
import '../../widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double paddingTop;
  final double sizeSpace;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.sizeSpace = 110,
      this.paddingTop = 70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppImageAsset.back)),
          ),
          SizedBox(
            width: Get.width - sizeSpace,
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
