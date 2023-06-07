import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../custom_text.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String body;
  final EdgeInsetsGeometry padding;
  const CustomRow({Key? key, required this.title, required this.body, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          CustomText(
            text: title,
            color: AppColors.black,
            textAlign: TextAlign.start,
            fontSize: 16,
          ),
          SizedBox(width: 8,),
          CustomText(
            text: body,
            color: AppColors.black,
            textAlign: TextAlign.start,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
