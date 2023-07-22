import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../custom_text.dart';

class CustomButtonLang extends StatelessWidget {
  final String textButton;
  final Function()? onPressed;
  const CustomButtonLang({Key? key, required this.textButton, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.primaryColor,
        textColor: Colors.white,
        child: CustomText(
          text: textButton,
          fontWeight: FontWeight.bold,
        ),
        // child: Text(textButton, style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
