import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';

import '../../controllers/settings_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/custom_text.dart';
import '../widgets/settings/custom_settings_row.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({Key? key}) : super(key: key);

  SettingsControllerImp controllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: CustomText(
              text: settings.tr,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              textAlign: TextAlign.center,
            ),
          ),
          CustomSettingsRow(
            onTap: () => controllerImp.goToMyAccount(),
              title: myAccount.tr, iconPath: AppImageAsset.person),
          Visibility(
            visible: controllerImp.appServices.getBoolSharedPreferences(SharedPrefKeys.IS_VENDOR),
            child: CustomSettingsRow(
              onTap: () => controllerImp.goToMyStore(),
              title: myStore.tr,
              iconPath: AppImageAsset.storeIcon,
              margin: EdgeInsets.only(top: 24),
            ),
          ),
          CustomSettingsRow(
            onTap: () => controllerImp.gotToLanguage(),
            title: language.tr,
            iconPath: AppImageAsset.world,
            margin: const EdgeInsets.only(top: 24),
          ),
          CustomSettingsRow(
            onTap: () => controllerImp.gotToHelpCenter(),
            title: helpCenter.tr,
            iconPath: AppImageAsset.help,
            margin: const EdgeInsets.only(top: 24),
          ),
          CustomSettingsRow(
            onTap: () => controllerImp.logout(),
            title: logOut.tr,
            iconPath: AppImageAsset.logOut,
            margin: EdgeInsets.only(top: 24),
          ),
        ],
      ),
    );
  }
}
