import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';

class ImagesDots extends StatelessWidget {
  final List<dynamic> images;
  final int currentIndex;
  final CarouselController controller;

  const ImagesDots(
      {Key? key,
      required this.images,
      required this.currentIndex,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blueIndicatorColor
                    .withOpacity(currentIndex == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
