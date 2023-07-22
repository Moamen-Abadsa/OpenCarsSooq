import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_color.dart';

class CustomTextFormSearch extends StatelessWidget {
  final String hintText;
  final String icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final EdgeInsetsGeometry? margin;
  ValueChanged<String>? onFieldSubmitted;
  ValueChanged<String>? onChanged;

  CustomTextFormSearch(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.keyboardType,
      required this.controller,
      this.onFieldSubmitted,
      this.onChanged,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        style: const TextStyle(
            fontSize: 14,
            color: AppColors.grayColor,
            fontFamily: 'Muli',
            fontWeight: FontWeight.w400),
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.grayColor,
              fontFamily: 'Muli',
              fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          fillColor: AppColors.graySearchColor,
          filled: true,
          prefixIcon: Container(
            height: 18,
            width: 15,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(5, 0, 6, 0),
            child: SvgPicture.asset(icon,
                height: 18, width: 15, fit: BoxFit.contain),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: AppColors.graySearchColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
