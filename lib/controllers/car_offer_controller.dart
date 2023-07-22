import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:opencarssooq/data/models/offer.dart';

import '../core/class/status_request.dart';
import '../core/functions/get_store_car.dart';
import '../core/functions/truncate_double.dart';
import '../core/localization/text_language_keys.dart';
import '../core/services/services.dart';
import '../data/models/car.dart';
import '../data/models/products_data.dart';
import '../data/models/store.dart';

abstract class CarOfferController extends GetxController {
  getCarData();

  createOffer();

  updateOffer();

  deleteOffer(String docId);

  onChangeText(String text);

  offerSettings(String text);

  getOfferData();

  onFieldSubmitted(String text);

  resetData();
}

class CarOfferControllerImp extends CarOfferController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> carOfferController =
      GlobalKey<FormState>(debugLabel: 'carOfferController');

  late TextEditingController tecNewPrice;
  late TextEditingController tecSearch;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference cars;

  AppServices appServices = Get.find();
  Car? car;
  double percent = 0;
  int oldPrice = 0;

  List<ProductsData> offerList = [];
  List<ProductsData> data = [];

  @override
  createOffer() async {
    if (carOfferController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Offer offer = Offer(car!.price!, tecNewPrice.text, percent);

      await cars
          .doc(car!.id)
          .update({'offer': offer.toJson()}).whenComplete(() {
        print("Success add offer car");
        StoreControllerImp controllerImp = Get.find();
        controllerImp.updateCarsOffer(car!.id!);
        statusRequest = StatusRequest.success;
        Get.back();
      }).catchError((error) {
        print("Failed to add offer car: $error");
        statusRequest = StatusRequest.failure;
      });

      update();
    }
  }

  @override
  deleteOffer(String docId) async {
    await cars.doc(car!.id).update({'offer': null}).then((value) {
      showSnackBar(message: deletedOfferSuccessfully.tr);
    }).catchError((error) {
      print("Failed to delete offer car: $error");
    });
  }

  @override
  getCarData() async {
    car = Get.arguments['car'];
    if (car!.hasOffer == true) {
      tecNewPrice.text = '${car!.newPrice!}';
      percent = car!.percent!;

      update();
    }

    oldPrice = replaceFormat(car!.price!);
  }

  @override
  updateOffer() async {
    if (carOfferController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Offer offer = Offer(car!.price!, tecNewPrice.text, percent);

      await cars
          .doc(car!.id)
          .update({'offer': offer.toJson()}).whenComplete(() {
        StoreControllerImp controllerImp = Get.find();
        controllerImp.updateCarsOffer(car!.id!);
        statusRequest = StatusRequest.success;
        Get.back();
      }).catchError((error) {
        print("Failed to update offer car: $error");
        statusRequest = StatusRequest.failure;
      });

      update();
    }
  }

  @override
  getOfferData() async {
    statusRequest = StatusRequest.loading;
    update();
    offerList.clear();
    data.clear();

    QuerySnapshot carsQuerySnapshot = await cars
        .where('offer', isNull: false)
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((onError) {
      statusRequest = StatusRequest.failure;
      print('getOfferData cars: ${onError.toString()}');
    });

    if (carsQuerySnapshot.docs.isNotEmpty) {
      for (var element in carsQuerySnapshot.docs) {
        Car car = Car.fromJson(
            element,
            appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID));

        var c = data.firstWhereOrNull((element) => element.store.id! == car.storeId!);
        ProductsData productsData;

        if(c == null) {
          Store store = await getStoreCar(car.storeId!);
          productsData = ProductsData(car, store);
        } else {
          productsData = ProductsData(car, c.store);
        }

        data.add(productsData);
      }
    }

    offerList = data;

    if(data.isEmpty) {
      statusRequest = StatusRequest.noDataFailure;
    }

    update();
  }

  @override
  void onInit() {
    tecNewPrice = TextEditingController();
    tecSearch = TextEditingController();
    cars = firestore.collection('cars');
    if (Get.arguments != null) {
      getCarData();
    } else if (Get.currentRoute == AppRoute.mainScreen) {
      getOfferData();
    }
    super.onInit();
  }

  @override
  void dispose() {
    tecNewPrice.dispose();
    tecSearch.dispose();
    super.dispose();
  }

  @override
  onChangeText(String text) {
    if (Get.currentRoute == AppRoute.mainScreen) {
      onFieldSubmitted(text);
    } else {
      offerSettings(text);
    }
  }

  @override
  offerSettings(String text) {
    if (text.isNotEmpty) {
      int newPrice = replaceFormat(text);
      percent = (oldPrice - newPrice) / oldPrice * 100;
      if (percent < 0) {
        percent = 100;
      }
      percent = truncateDouble(percent, 1);
    } else {
      percent = 0;
    }
    update();
  }

  int replaceFormat(String s) {
    s = s.replaceAll('.', '');
    s = s.replaceAll(',', '');
    return int.parse(s);
  }

  @override
  onFieldSubmitted(String value) async {
    if (value.isNotEmpty) {
      final suggestions = offerList.where((product) {
        final name = product.car.name!.toLowerCase();
        return name.contains(value.toLowerCase());
      }).toList();
      offerList = suggestions;
    } else {
      resetData();
    }

    update();
  }

  @override
  resetData() {
    offerList = data;
  }
}
