import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../custom_text.dart';

class ListRow extends StatelessWidget {
  final String textOne;
  final String textTow;
  final GestureTapCallback? onTapOne;
  final GestureTapCallback? onTapTow;

  const ListRow(
      {Key? key,
      required this.textOne,
      required this.textTow,
      this.onTapOne,
      this.onTapTow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTapOne,
          child: CustomText(
            text: textOne,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            textAlign: TextAlign.left,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTapTow,
          child: CustomText(
            text: textTow,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grey2,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
