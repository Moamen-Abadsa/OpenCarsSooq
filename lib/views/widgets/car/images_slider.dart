import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/functions/encode_decode_image64.dart';

class ImagesSlider extends StatelessWidget {
  final List<dynamic> images;
  final CarouselController controller;
  final int currentIndex;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const ImagesSlider(
      {Key? key,
      required this.images,
      required this.controller,
      required this.currentIndex,
      required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.memory(
            imageBase64Decode(images[itemIndex]),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        // items: [
        //   Image.memory(
        //     imageBase64Decode(images[currentIndex]),
        //     fit: BoxFit.cover,
        //     width: double.infinity,
        //   )
        // ],
        carouselController: controller,
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}
