import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';

import '../core/class/status_request.dart';
import '../core/functions/truncate_double.dart';
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
  late CollectionReference offersCars;
  late CollectionReference stores;

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

      Map<String, dynamic> map = {
        'carId': car!.id!,
        'oldPrice': car!.price!,
        'newPrice': '${tecNewPrice.text}',
        'percent': percent,
      };

      await offersCars.add(map).whenComplete(() {
        print("Success add offer car");
        StoreControllerImp controllerImp = Get.find();
        controllerImp.updateCarsOffer();
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
    offersCars.doc(docId).delete().then((value) {
      showSnackBar(message: 'Deleted offer successfully');
    }).catchError((error) {
      print("Failed to delete offer car: $error");
    });
  }

  @override
  getCarData() async {
    car = Get.arguments['car'];
    if (car!.hasOffer == true) {
      statusRequest = StatusRequest.loading;
      update();

      DocumentSnapshot querySnapshot =
          await offersCars.doc(car!.offerId).get().whenComplete(() {
        statusRequest = StatusRequest.success;
      }).catchError((error) {
        print("Failed to get offer car: $error");
        statusRequest = StatusRequest.failure;
      });

      if (querySnapshot.exists) {
        tecNewPrice.text = '${querySnapshot.get('newPrice')}';
        percent = querySnapshot.get('percent');
      }

      update();
    }

    oldPrice = replaceFormat(car!.price!);
  }

  @override
  updateOffer() async {
    if (carOfferController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic> map = {
        'carId': car!.id!,
        'oldPrice': car!.price!,
        'newPrice': '${tecNewPrice.text}',
        'percent': percent,
      };

      await offersCars.doc(car!.offerId).update(map).whenComplete(() {
        StoreControllerImp controllerImp = Get.find();
        controllerImp.updateCarsOffer();
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

    QuerySnapshot offersQuerySnapshot = await offersCars
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((onError) {
      statusRequest = StatusRequest.failure;
    });

    QuerySnapshot carsQuerySnapshot = await cars
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((onError) {
      statusRequest = StatusRequest.failure;
      print('getOfferData cars: ${onError.toString()}');
    });

    if (carsQuerySnapshot.docs.isNotEmpty) {
      for (var element in carsQuerySnapshot.docs) {
        var offers = offersQuerySnapshot.docs
            .firstWhereOrNull((e) => e['carId'] == element.id);

        if (offers != null) {

          Car car = Car(
              id: element.id,
              name: element['name'],
              price: element['price'],
              description: element['description'],
              images: element['images'],
              storeId: element['storeId'],
              newPrice: offers['newPrice'],
              percent: offers['percent']);

          DocumentSnapshot storesDocumentSnapshot =
          await stores.doc(car.storeId!).get();

          Store store = Store();
          store.name = storesDocumentSnapshot.get('name');
          store.logo = storesDocumentSnapshot.get('logo');
          store.phone = storesDocumentSnapshot.get('phone');

          data.add(ProductsData(car, store));

        }
      }
    }

    offerList = data;

    update();
  }

  @override
  void onInit() {
    tecNewPrice = TextEditingController();
    tecSearch = TextEditingController();
    cars = firestore.collection('cars');
    offersCars = firestore.collection('offersCars');
    stores = firestore.collection('stores');
    if(Get.arguments != null) {
      getCarData();
    } else if(Get.currentRoute == AppRoute.mainScreen) {
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
    if(Get.currentRoute == AppRoute.mainScreen) {
        onFieldSubmitted(text);
    } else {
      offerSettings(text);
    }
  }

  @override
  offerSettings(String text) {
    if(text.isNotEmpty) {
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
