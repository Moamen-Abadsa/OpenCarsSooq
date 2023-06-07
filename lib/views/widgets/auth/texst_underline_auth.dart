import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';


class TextUnderlineAuth extends StatelessWidget {
  final String text;
  final Color color;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final bool hasUnderline;
  final double fontSize;
  final FontWeight fontWeight;
  final GestureTapCallback? onTap;
  final AlignmentGeometry alignment;

  const TextUnderlineAuth(
      {Key? key,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginTop = 0,
      this.marginBottom = 0,
      required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w600,
      this.color = AppColors.black,
      this.hasUnderline = true,
      this.alignment = Alignment.centerRight,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        margin: EdgeInsets.only(
            bottom: marginBottom,
            top: marginTop,
            left: marginLeft,
            right: marginRight),
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
              height: 1.4,
              color: color,
              fontFamily: 'Muli',
              fontWeight: fontWeight,
              fontSize: fontSize,
              decoration: hasUnderline ? TextDecoration.underline : null,
              decorationThickness: hasUnderline ? 1 : 0),
        ),
      ),
    );
  }
}
