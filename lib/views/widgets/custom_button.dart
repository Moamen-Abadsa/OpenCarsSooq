import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_color.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double shape;
  final double? width;
  final double? height;
  final double textSize;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.margin,
      this.shape = 28,
      this.width,
      this.height = 35,
      this.textSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(shape)),
        child: CustomText(
          text: text,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          fontSize: textSize,
        ),
      ),
    );
  }
}
