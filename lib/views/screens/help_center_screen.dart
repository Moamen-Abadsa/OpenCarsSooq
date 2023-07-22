import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/help_controller.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../core/localization/text_language_keys.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/help_center/custom_contact_us_row.dart';
import '../widgets/help_center/custom_help_column.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({Key? key}) : super(key: key);

  HelpControllerImp controllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                title: helpCenter.tr,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: faq.tr,
                  fontSize: 18,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomHelpColumn(
                text: helpCenter1.tr,
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: helpCenter2.tr,
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: helpCenter3.tr,
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: helpCenter1.tr,
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: helpCenter4.tr,
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: helpCenter5.tr,
                paddingBottom: 0,
              ),
              Container(
                margin: const EdgeInsets.all(24),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: contactUs.tr,
                  fontSize: 18,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.contactUs,
                title: chatUsNow.tr,
                body: chatHere.tr,
                onTap: () => controllerImp.callToSupportWA(),
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.sendEmail,
                title: chatUsNow.tr,
                body: chatHere.tr,
                onTap: () => controllerImp.callToSupportEmail(),
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.callUs,
                title: chatUsNow.tr,
                body: chatHere.tr,
                onTap: () => controllerImp.callToSupportPhone(),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CustomText(
                  text: '© Copyright 2023 - O.C.S',
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
