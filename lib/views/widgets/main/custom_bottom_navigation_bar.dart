import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/main_controller.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: DotNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.onItemTapped(index),
          items: [
            buildBottomNavigationBarItem(
              icon: AppImageAsset.home,
              color: controller.currentIndex == 0
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
            buildBottomNavigationBarItem(
              icon: AppImageAsset.heart,
              color: controller.currentIndex == 1
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
            buildBottomNavigationBarItem(
              icon: AppImageAsset.offers,
              color: controller.currentIndex == 2
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
            buildBottomNavigationBarItem(
              icon: AppImageAsset.search,
              color: controller.currentIndex == 3
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
            buildBottomNavigationBarItem(
              icon: AppImageAsset.setting,
              color: controller.currentIndex == 4
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
            ),
          ],
          borderRadius: 40,
          paddingR: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          marginR: EdgeInsets.zero,
          dotIndicatorColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  DotNavigationBarItem buildBottomNavigationBarItem(
      {required String icon, required Color color}) {
    return DotNavigationBarItem(
        icon: SvgPicture.asset(icon, width: 24, height: 24, color: color),
        selectedColor: AppColors.primaryColor,
        unselectedColor: AppColors.grayColor);
  }
}
