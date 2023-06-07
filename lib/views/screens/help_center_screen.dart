import 'package:flutter/material.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/help_center/custom_contact_us_row.dart';
import '../widgets/help_center/custom_help_column.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(
                title: 'Help Center',
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                alignment: Alignment.centerLeft,
                child: const CustomText(
                  text: 'FAQ',
                  fontSize: 18,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomHelpColumn(
                text: 'How does warranty work on store?',
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: 'How long is my order delivery time?',
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: 'How to become a store seller?',
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: 'How does warranty work on store?',
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: "Why I don't accept otp on my phone?",
                paddingBottom: 13,
              ),
              CustomHelpColumn(
                text: 'How to rate my order products?',
                paddingBottom: 0,
              ),
              Container(
                margin: const EdgeInsets.all(24),
                alignment: Alignment.centerLeft,
                child: const CustomText(
                  text: 'Contact Us',
                  fontSize: 18,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.contactUs,
                title: 'Chat us now',
                body: 'You can chat with us here',
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.sendEmail,
                title: 'Chat us now',
                body: 'You can chat with us here',
              ),
              CustomContactUsRow(
                iconPath: AppImageAsset.callUs,
                title: 'Chat us now',
                body: 'You can chat with us here',
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
