import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/views/widgets/custom_text.dart';

class CustomContactUsRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String body;
  final GestureTapCallback? onTap;

  const CustomContactUsRow(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.body,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 48,
              height: 48,
            ),
            const SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  textAlign: TextAlign.left,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                const SizedBox(
                  height: 6,
                ),
                CustomText(
                  text: body,
                  textAlign: TextAlign.left,
                  fontSize: 14,
                  color: AppColors.grey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
