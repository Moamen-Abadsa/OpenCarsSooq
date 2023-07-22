import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/grid_fixed_items_height.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_image_asset.dart';
import '../../core/constant/app_route.dart';
import '../../core/constant/shared_preference_keys.dart';
import '../../core/localization/changelocal.dart';
import '../../core/localization/text_language_keys.dart';
import '../../core/services/services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text.dart';
import '../widgets/language/custom_card_language.dart';
import '../widgets/rounded_image.dart';

class LanguageScreen extends GetView<LocalController> {
  LanguageScreen({Key? key}) : super(key: key);

  AppServices appServices = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayBgLangColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              title: language.tr,
            ),
            CustomText(
              text: chooseLang.tr,
              color: AppColors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  CustomCardLanguage(
                    onTap: () {
                      chooseLangAction("ar");
                    },
                    imagePath: AppImageAsset.jordanFlag,
                    title: ar.tr,
                  ),
                  CustomCardLanguage(
                    onTap: () {
                      chooseLangAction("en");
                    },
                    imagePath: AppImageAsset.britishFlag,
                    title: en.tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chooseLangAction(String lang) {
    controller.changeLang(lang);
    appServices.sharedPreferences.setString(SharedPrefKeys.LANG, lang);

    Get.back();
  }

}
