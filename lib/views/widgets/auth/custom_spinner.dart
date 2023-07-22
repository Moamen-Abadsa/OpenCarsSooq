import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';

import '../../../core/constant/app_color.dart';

class CustomSpinner extends StatelessWidget {
  final String hint;
  final dynamic selectedValue;
  final String requiredValue;
  final List<DropdownMenuItem<dynamic>> items;
  final ValueChanged<dynamic>? onChanged;
  final EdgeInsetsGeometry? margin;

  const CustomSpinner(
      {Key? key,
      required this.hint,
      required this.selectedValue,
      required this.items,
      required this.requiredValue,
      this.margin,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayColor),
          borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          border: InputBorder.none,
        ),
        hint: Text(
          hint,
          style: const TextStyle(
            height: 1.4,
            color: AppColors.grayColor,
            fontFamily: 'Muli',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        style: const TextStyle(
          height: 1.4,
          color: AppColors.grayColor,
          fontFamily: 'Muli',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        isExpanded: true,
        icon: SvgPicture.asset(AppImageAsset.dropDown),
        validator: (value) => value == null ? requiredValue : null,
        iconSize: 30,
        value: selectedValue,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomLabeledSpinner extends StatelessWidget {
  final String hint;
  final String label;
  final dynamic selectedValue;
  final String requiredValue;
  final List<DropdownMenuItem<dynamic>>? items;
  final ValueChanged<dynamic>? onChanged;
  final EdgeInsetsGeometry? margin;

  const CustomLabeledSpinner(
      {Key? key,
      required this.hint,
      required this.label,
      required this.selectedValue,
      required this.items,
      required this.requiredValue,
      this.margin,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
          labelText: label,
          labelStyle: const TextStyle(
            height: 1.4,
            color: AppColors.grayColor,
            fontFamily: 'Muli',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.0)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            value: selectedValue,
            icon: SvgPicture.asset(AppImageAsset.dropDown),
            iconSize: 24,
            elevation: 16,
            hint: Text(
              hint,
              style: const TextStyle(
                height: 1.4,
                color: AppColors.grayColor,
                fontFamily: 'Muli',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            style: const TextStyle(
              height: 1.4,
              color: AppColors.grayColor,
              fontFamily: 'Muli',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            onChanged: onChanged,
            items: items,
          ),
        ),
      ),
    );
  }
}
