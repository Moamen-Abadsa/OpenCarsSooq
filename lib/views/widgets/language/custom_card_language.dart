import 'package:flutter/material.dart';

import '../custom_text.dart';
import '../rounded_image.dart';

class CustomCardLanguage extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String imagePath;
  final String title;

  const CustomCardLanguage(
      {Key? key, this.onTap, required this.imagePath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            RoundedImage(
              height: 80,
              width: 80,
              imagePath: imagePath,
              borderRadius: BorderRadius.circular(100),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              text: title,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )
          ],
        ),
      ),
    );
  }
}
