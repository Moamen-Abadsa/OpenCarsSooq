import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

import '../../../core/constant/app_color.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final EdgeInsetsGeometry? margin;
  final ValueChanged<String>? onChanged;

  CustomTextForm(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.keyboardType,
      required this.controller,
      this.margin,
      this.onChanged,
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
        onChanged: onChanged,
        maxLines: keyboardType == TextInputType.multiline ? 7 : 1,
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                    width: 2, color: AppColors.grayColor))),
      ),
    );
  }
}
