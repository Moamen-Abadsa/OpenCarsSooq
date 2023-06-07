import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/app_color.dart';

import '../../core/constant/app_image_asset.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppImageAsset.back)),
          ),
          SizedBox(
            width: Get.width - 120,
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
