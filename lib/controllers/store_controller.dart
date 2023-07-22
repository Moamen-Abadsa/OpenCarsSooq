import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/car_offer_controller.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:opencarssooq/data/models/store.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/class/life_cycle_controller.dart';
import '../core/class/status_request.dart';
import '../core/constant/app_image_asset.dart';
import '../core/constant/app_route.dart';
import '../core/constant/shared_preference_keys.dart';
import '../core/functions/truncate_double.dart';
import '../core/localization/text_language_keys.dart';
import '../core/services/services.dart';
import '../data/models/car.dart';
import 'package:collection/collection.dart';

import 'favorite_cars_controller.dart';

abstract class StoreController extends GetxController {
  Future<void> getStoreData(String storeId, bool isEdited);

  Future<void> getStoreCars(String storeId, bool isAddCar);

  void goToAddCar();

  Future<void> refreshCars();

  Future<void> openLink(String link);

  void goToRateStore();

  Future<void> getStoreRating(bool isAdded);

  void goToEditStore();

  void goToEditCarStore(Car car, int index);

  void goToAddCarOffer(Car car);

  void goToEditCarOffer(Car car);

  void deleteCarOffer(Car car);

  void deleteCarStore(String carId, int index);

  Future<void> clickHeart(Car car);
}

class StoreControllerImp extends StoreController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest carsStatusRequest = StatusRequest.loading;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference feedback;
  late CollectionReference stores;
  late CollectionReference cars;

  Store? store;
  double storeRate = 0;

  List<Car> storeCars = [];

  AppServices appServices = Get.find();
  bool isVendor = false;
  String storeId = '';
  int carListIndex = -1;

  FavoriteCarControllerImp favCarControllerImp = Get.find();

  @override
  Future<void> getStoreData(String storeId, bool isEdited) async {
    statusRequest = StatusRequest.loading;
    update();

    DocumentSnapshot documentSnapshot = await stores
        .doc(storeId)
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((error) {
      statusRequest = StatusRequest.failure;
      print("Failed to get store: $error");
    });

    if (documentSnapshot.exists) {
      store = Store(
          vendorId: '${Get.arguments['userId']}',
          logo: documentSnapshot.get('logo'),
          name: documentSnapshot.get('name'),
          address: documentSnapshot.get('address'),
          phone: documentSnapshot.get('phone'),
          state: documentSnapshot.get('state'),
          fbLink: documentSnapshot.get('fbLink'),
          instaLink: documentSnapshot.get('instaLink'),
          wtLink: documentSnapshot.get('wtLink'),
          storeRate: documentSnapshot.get('storeRate') != null ? documentSnapshot.get('storeRate') : 0);

      storeRate = store!.storeRate!;

      if(isEdited == false) {
        getStoreCars(storeId, false);
      }
    } else {
      statusRequest = StatusRequest.noDataFailure;
    }

    update();
  }

  @override
  Future<void> getStoreCars(String storeId, bool isAddCar) async {
    QuerySnapshot carsQuerySnapshot = await cars
        .where('storeId', isEqualTo: storeId)
        .get()
        .whenComplete(() => carsStatusRequest = StatusRequest.success)
        .catchError((error) {
      carsStatusRequest = StatusRequest.failure;
      print("Failed to get cars store: $error");
    });

    if (carsQuerySnapshot.docs.isNotEmpty) {
      for (int i = 0; i < carsQuerySnapshot.docs.length; i++) {
        Car car = Car.fromJson(carsQuerySnapshot.docs[i], appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID));

        storeCars.add(car);
      }
    } else {
      carsStatusRequest = StatusRequest.noDataFailure;
    }

    // if (isAddCar) update();
    update();
  }

  void updateCarsOffer(String carId) async {
    carsStatusRequest = StatusRequest.loading;
    update();

    DocumentSnapshot documentSnapshot = await cars.doc(carId).get();

    if (documentSnapshot.exists) {
      var car = storeCars.firstWhereOrNull((element) => documentSnapshot.id == carId);
      if(car != null) {
        car.hasOffer = true;
        car.newPrice = documentSnapshot.get('offer')['newPrice'];
        car.percent = documentSnapshot.get('offer')['percent'];
      }
    }

    carsStatusRequest = StatusRequest.success;
    update();
  }

  @override
  void goToAddCar() {
    Get.toNamed(AppRoute.addCarScreen,
        arguments: {'storeId': storeId});
  }

  @override
  Future<void> refreshCars() async {
    carsStatusRequest = StatusRequest.loading;
    update();

    QuerySnapshot carsQuerySnapshot = await cars
        .where('storeId', isEqualTo: storeId)
        .orderBy('actionTime', descending: true)
        .limit(1)
        .get()
        .whenComplete(() => carsStatusRequest = StatusRequest.success)
        .catchError((error) {
      carsStatusRequest = StatusRequest.failure;
      print("Failed to get cars store: $error");
    });

    if (carsQuerySnapshot.docs.isNotEmpty) {
      Car car;
      if (carListIndex == -1) {
        car = Car.fromJson(carsQuerySnapshot.docs[0], appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID));

        storeCars.add(car);
      } else {
        car = storeCars[carListIndex];
        car.id = carsQuerySnapshot.docs[0].id;
        car.name = carsQuerySnapshot.docs[0]['name'];
        car.price = carsQuerySnapshot.docs[0]['price'];
        car.description = carsQuerySnapshot.docs[0]['description'];
        car.images = carsQuerySnapshot.docs[0]['images'];
        car.favorites = carsQuerySnapshot.docs[0]['favorites'];
        car.offer = carsQuerySnapshot.docs[0]['offer'];
        car.storeId = storeId;
      }
    }

    carListIndex = -1;
    update();
  }

  @override
  Future<void> openLink(String link) async {
    if (link.isNotEmpty) {
      if (!await launchUrl(Uri.parse(link))) {
        throw Exception('Could not launch $link');
      }
    } else {
      showSnackBar(message: thisLinkIsEmpty.tr);
    }
  }

  @override
  void goToRateStore() {
    Get.toNamed(AppRoute.addFeedbackScreen,
        arguments: {'storeId': storeId, 'storeLogo': store!.logo!});
  }

  @override
  Future<void> getStoreRating(bool isAdded) async {
    QuerySnapshot querySnapshot = await feedback
        .where('storeId', isEqualTo: storeId)
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((error) {
      statusRequest = StatusRequest.failure;
      print("Failed to get rate store: $error");
    });

    if (querySnapshot.docs.isNotEmpty) {
      var result =
          querySnapshot.docs.map((m) => m['rating']).reduce((a, b) => a + b) /
              querySnapshot.docs.length;

      storeRate = truncateDouble(result, 1);

      stores.doc(storeId).update({'storeRate' : storeRate});

      update();
    }
  }

  @override
  void goToEditStore() {
    Get.toNamed(AppRoute.editStoreScreen, arguments: {
      'storeId': storeId,
      'storeData': store,
    });
  }

  @override
  Future<void> clickHeart(Car car) async {
    if (!car.isFav) {
      car.favId = await favCarControllerImp.addFavCar(car.id!);
    } else {
      favCarControllerImp.removeFavCar(car.favId!);
    }

    car.isFav = !car.isFav;

    update();
  }

  @override
  void onInit() {
    feedback = firestore.collection('feedback');
    stores = firestore.collection('stores');
    cars = firestore.collection('cars');
    storeId = Get.arguments['storeId'];
    isVendor = storeId ==
        appServices.getStringSharedPreferences(SharedPrefKeys.STORE_ID);

    getStoreData(storeId, false);
    super.onInit();
  }

  @override
  void deleteCarStore(String carId, int index) async {
    await Future.delayed(Duration.zero);
    cars.doc(carId).delete().whenComplete(() {
      storeCars.removeAt(index);
      showSnackBar(message: deletedCarSuccessfully.tr);
      update();
    }).catchError((error) {
      print("Failed to delete car: $error");
    });
  }

  @override
  void goToEditCarStore(Car car, int index) async {
    await Future.delayed(Duration.zero);
    carListIndex = index;
    Get.toNamed(AppRoute.editCarScreen,
        arguments: {'car': car});
  }

  @override
  void goToAddCarOffer(Car car) async {
    await Future.delayed(Duration.zero);
    Get.delete<CarOfferControllerImp>();
    Get.toNamed(AppRoute.addOfferScreen, arguments: {'car': car});
  }

  @override
  void goToEditCarOffer(Car car) async {
    await Future.delayed(Duration.zero);
    Get.delete<CarOfferControllerImp>();
    Get.toNamed(AppRoute.editOfferScreen, arguments: {'car': car});
  }

  @override
  void deleteCarOffer(Car car) async {
    await Future.delayed(Duration.zero);
    cars.doc(car.id).update({'offer': null}).whenComplete(() {
      showSnackBar(message: deletedCarOfferSuccessfully.tr);
      car.hasOffer = false;
      car.offerId = null;
      update();
    }).catchError((error) {
      print("Failed to delete car offer: $error");
    });
  }
}
