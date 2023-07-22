import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../../core/constant/app_color.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final EdgeInsetsGeometry? margin;

  CustomTextFormAuth(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.keyboardType,
      required this.controller,
      this.margin,
      this.valid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        validator: valid,
        keyboardType: keyboardType,
        style: const TextStyle(
            fontSize: 16,
            color: AppColors.grayColor,
            fontFamily: 'Muli',
            fontWeight: FontWeight.w400),
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16,
                color: AppColors.grayColor,
                fontFamily: 'Muli',
                fontWeight: FontWeight.w400),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: CustomText(
                text: labelText,
                fontSize: 18,
                color: AppColors.grayColor,
              ),
            ),
            suffixIcon: Container(
              height: 18,
              width: 15,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: SvgPicture.asset(icon,
                  height: 18, width: 15, fit: BoxFit.contain),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                    width: 2, color: AppColors.grayColor))),
      ),
    );
  }
}
