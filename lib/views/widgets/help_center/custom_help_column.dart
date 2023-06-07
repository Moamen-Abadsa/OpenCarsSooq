import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../custom_text.dart';

class CustomHelpColumn extends StatelessWidget {
  final String text;
  final double paddingBottom;
  const CustomHelpColumn({Key? key, required this.text, this.paddingBottom = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, paddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: AppColors.black,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 13,),
          const Divider(
            color: AppColors.grayDividerColor,
            height: 1,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
