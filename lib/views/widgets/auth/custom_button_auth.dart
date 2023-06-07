import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_color.dart';
import '../custom_text.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;

  const CustomButtonAuth(
      {Key? key, required this.text, required this.onPressed, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 56,
      margin: margin,
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: CustomText(
          text: text,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          fontSize: 18,
        ),
      ),
    );
  }
}
