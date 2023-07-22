import 'package:flutter/material.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../../core/constant/app_color.dart';

class CustomTextSignUpOrSignIn extends StatelessWidget {
  final String textOne;
  final String textTow;
  final void Function()? onTap;

  const CustomTextSignUpOrSignIn(
      {Key? key,
      required this.textOne,
      required this.textTow,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(text: '$textOne  ', color: AppColors.grayColor,),
        InkWell(
          onTap: onTap,
          child: CustomText(
            text: textTow,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
