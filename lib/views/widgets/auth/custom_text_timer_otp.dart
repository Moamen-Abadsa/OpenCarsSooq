import 'package:flutter/material.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../../core/constant/app_color.dart';

class CustomTextTimerOTP extends StatelessWidget {
  final String textTitle;
  final String textTimer;

  const CustomTextTimerOTP(
      {Key? key, required this.textTitle, required this.textTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '$textTitle ',
        style: const TextStyle(
            color: AppColors.grayColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Muli'),
        children: <TextSpan>[
          TextSpan(
            text: textTimer,
            style: const TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Muli'),
          ),
        ],
      ),
    );
  }
}
