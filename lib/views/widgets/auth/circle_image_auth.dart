import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:opencarssooq/views/widgets/rounded_image.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/functions/encode_decode_image64.dart';

class CircleImageAuth extends StatelessWidget {
  final GestureTapCallback? onTap;
  final File? selectedImage;
  final String? base64Logo;

  const CircleImageAuth(
      {Key? key, this.onTap, this.selectedImage, this.base64Logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        selectedImage == null && base64Logo == null
            ? Image.asset(
                AppImageAsset.bgStore,
                fit: BoxFit.cover,
                width: 180,
                height: 180,
              )
            : Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: base64Logo != null
                      ? Image.memory(
                          imageBase64Decode(base64Logo!),
                          fit: BoxFit.cover,
                          width: 177,
                          height: 177,
                        )
                      : Image.file(
                          File(selectedImage!.path),
                          fit: BoxFit.cover,
                          width: 177,
                          height: 177,
                        ),
                ),
              ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(top: 122),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.primaryColor),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
