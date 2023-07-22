import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';

import '../core/class/status_request.dart';
import '../core/constant/shared_preference_keys.dart';
import '../core/functions/chopping_of_text.dart';
import '../core/functions/get_store_car.dart';
import '../core/functions/store_states.dart';
import '../core/services/services.dart';
import '../data/models/car.dart';
import '../data/models/products_data.dart';
import '../data/models/store.dart';
import 'favorite_cars_controller.dart';

abstract class SearchController extends GetxController {
  Future<void> startSearch(String query);

  Future<void> initPage();

  void fiterResult();

  clickHeart(Car car);
}

class SearchControllerImp extends SearchController {

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController tecSearch;
  List<ProductsData> carsList = [];
  List<ProductsData> data = [];

  FavoriteCarControllerImp favCarControllerImp = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference stores;
  late CollectionReference cars;

  AppServices appServices = Get.find();

  late QuerySnapshot favQuerySnapshot;

  @override
  Future<void> startSearch(String query) async {
    if(query.isNotEmpty) {
      statusRequest = StatusRequest.loading;
      update();

      data.clear();
      carsList.clear();

      QuerySnapshot carsSnapshot = await cars
        .where('searchKeywords', arrayContainsAny: choppingOfText(query))
        .get();

      if(carsSnapshot.docs.isNotEmpty) {
        for(var element in carsSnapshot.docs) {
          Car car = Car.fromJson(element, appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID));

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

      carsList.addAll(data);

      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  clickHeart(Car car) async {
    if (!car.isFav) {
      car.favId = await favCarControllerImp.addFavCar(car.id!);
    } else {
      favCarControllerImp.removeFavCar(car.favId!);
    }

    car.isFav = !car.isFav;

    update();
  }

  @override
  Future<void> initPage() async {
    data.clear();
    update();
  }

  @override
  void fiterResult() {
    if(data.isNotEmpty) {
      carsList.clear();

      carsList.addAll(data..sort((a, b) => a.store.state!.compareTo(b.store.state!)));

      update();
    }
  }

  @override
  void onInit() {
    stores = firestore.collection('stores');
    cars = firestore.collection('cars');
    tecSearch = TextEditingController();
    initPage();
    super.onInit();
  }

  @override
  void dispose() {
    tecSearch.dispose();
    super.dispose();
  }

}