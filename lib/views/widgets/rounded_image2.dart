import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_image_asset.dart';
import '../../core/functions/encode_decode_image64.dart';

class RoundedImage2 extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;
  final String imagePath;

  const RoundedImage2(
      {Key? key,
      this.borderRadius = const BorderRadius.only(
          topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      this.width = double.infinity,
      this.height = 130,
      this.imagePath = AppImageAsset.car})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.memory(imageBase64Decode(imagePath),
          width: width, height: height, fit: BoxFit.cover),
    );
  }
}
