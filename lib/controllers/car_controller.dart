import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/services/services.dart';
import 'package:opencarssooq/data/models/car.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_image_asset.dart';
import '../core/constant/shared_preference_keys.dart';
import '../core/functions/chopping_of_text.dart';
import '../core/functions/custom_snackbar.dart';
import '../core/functions/encode_decode_image64.dart';
import '../core/localization/text_language_keys.dart';
import '../data/models/store.dart';
import 'favorite_cars_controller.dart';

abstract class CarController extends GetxController {
  createCar();

  pickImage();

  changeImageIndex(int index);

  clickHeart();

  getCarData(Car car);

  updateCar();
}

class CarControllerImp extends CarController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> carController =
      GlobalKey<FormState>(debugLabel: 'carController');

  List<File> carImages = [];
  List<dynamic> carImages64 = [];

  late TextEditingController tecName;
  late TextEditingController tecPrice;
  late TextEditingController tecDescription;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference cars;

  int currentImageIndex = 0;
  final CarouselController imagesController = CarouselController();

  FavoriteCarControllerImp favCarControllerImp = Get.find();
  String heartIcon = AppImageAsset.heart;

  AppServices appServices = Get.find();

  Car? car;
  Store? store;
  bool isVendor = false;

  @override
  createCar() async {
    if (carController.currentState!.validate()) {
      if (carImages.isNotEmpty) {
        statusRequest = StatusRequest.loading;
        update();

        Map<String, dynamic> car = {
          'name': tecName.text,
          'price': tecPrice.text,
          'description': tecDescription.text,
          'images': convertFilesIntoBase64(carImages),
          'storeId': Get.arguments['storeId'],
          'actionTime': DateTime.now().microsecondsSinceEpoch,
          'searchKeywords' : choppingOfText(tecName.text),
          'favorites' : [],
          'offer' : null
        };

        cars.add(car).then((value) {
          statusRequest = StatusRequest.success;
          StoreControllerImp controllerImp = Get.find();
          controllerImp.refreshCars();
          Get.back();

          update();
        }).catchError((error) {
          statusRequest = StatusRequest.success;
          print("Failed to add car: $error");
          update();
        });
      } else {
        showSnackBar(message: chooseImagesForCar.tr);
      }
    }
  }

  @override
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final List<XFile> images = await picker.pickMultiImage(maxHeight: 600, maxWidth: 600, imageQuality: 80);

    if (images.isNotEmpty) {
      carImages64.clear();
      carImages.clear();
      images.forEach((image) {
        carImages.add(File(image.path));
      });
    }

    update();
  }

  @override
  changeImageIndex(int index) {
    currentImageIndex = index;
    update();
  }

  void init() {
    final map = Get.arguments as Map;
    if (map.containsKey('car') && map.containsKey('store')) {
      car = Get.arguments['car'];
      store = Get.arguments['store'];
      isVendor = car!.storeId ==
          appServices.getStringSharedPreferences(SharedPrefKeys.STORE_ID);
      heartIcon = car!.isFav ? AppImageAsset.heartFill : AppImageAsset.heart;
    } else if (map.containsKey('car')) {
      car = Get.arguments['car'];
      isVendor = car!.storeId ==
          appServices.getStringSharedPreferences(SharedPrefKeys.STORE_ID);
      getCarData(car!);
    }
  }

  @override
  void onInit() {
    tecName = TextEditingController();
    tecPrice = TextEditingController();
    tecDescription = TextEditingController();
    cars = firestore.collection('cars');
    init();
    super.onInit();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecPrice.dispose();
    tecDescription.dispose();
    super.dispose();
  }

  @override
  clickHeart() async {
    if (!car!.isFav) {
      car!.favId = await favCarControllerImp.addFavCar(car!.id!);
    } else {
      favCarControllerImp.removeFavCar(car!.favId!);
    }

    car!.isFav = !car!.isFav;

    heartIcon = car!.isFav ? AppImageAsset.heartFill : AppImageAsset.heart;

    update();
  }

  @override
  getCarData(Car car) async {
    tecName.text = car.name!;
    tecDescription.text = car.description!;
    tecPrice.text = car.price!;
    carImages64.addAll(car.images!);

    update();
  }

  @override
  updateCar() async {
    if (carController.currentState!.validate()) {
      if (carImages.isNotEmpty || carImages64.isNotEmpty) {
        statusRequest = StatusRequest.loading;
        update();

        Map<String, dynamic> carMap = {
          'name': tecName.text,
          'price': tecPrice.text,
          'description': tecDescription.text,
          'images': carImages.isNotEmpty
              ? convertFilesIntoBase64(carImages)
              : carImages64,
          'storeId': car!.storeId,
          'actionTime': DateTime.now().microsecondsSinceEpoch,
          'searchKeywords' : choppingOfText(tecName.text)
        };

        cars.doc(car!.id).update(carMap).whenComplete(() {
          // StoreControllerImp controllerImp = Get.find(); // bug when update from details car screen
          // controllerImp.refreshCars();
          statusRequest = StatusRequest.success;

          Get.back();
        }).catchError((error) {
          statusRequest = StatusRequest.failure;
          print("Failed to update car: $error");
        });

        update();
      } else {
        showSnackBar(message: chooseImagesForCar.tr);
      }
    }
  }
}
