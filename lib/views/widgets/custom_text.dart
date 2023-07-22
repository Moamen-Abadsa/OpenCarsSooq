import 'package:flutter/material.dart';
import '../../core/constant/app_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final int? maxLines;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double height;
  final TextDecoration? decoration;

  const CustomText(
      {Key? key,
      required this.text,
      this.color = AppColors.grey,
      this.textAlign = TextAlign.center,
      this.fontSize = 16,
      this.maxLines = 1,
      this.height = 1.3,
      this.fontWeight = FontWeight.w400,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Muli',
        height: height,
        decoration: decoration
      ),
    );
  }
}
