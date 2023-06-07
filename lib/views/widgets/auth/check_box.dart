import 'package:flutter/material.dart';
import 'package:opencarssooq/core/constant/app_color.dart';

import '../custom_text.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
            activeColor: AppColors.primaryColor,
          ),
          CustomText(
            text: label,
            fontSize: 16,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w400,
            color: AppColors.grayColor,
          ),
        ],
      ),
    );
  }
}
