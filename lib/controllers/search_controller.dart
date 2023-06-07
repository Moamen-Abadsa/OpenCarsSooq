import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';

import '../core/class/status_request.dart';
import '../core/constant/shared_preference_keys.dart';
import '../core/functions/chopping_of_text.dart';
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
  late CollectionReference favoriteCars;

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
        for(var c in carsSnapshot.docs) {
           Car car = Car(
            id: c.id,
            name: c['name'],
            price: c['price'],
            description: c['description'],
            images: c['images'],
            storeId: c['storeId']);

          var favs = favQuerySnapshot.docs
              .where((element) => element['carId'] == car.id)
              .toList();
          if (favs.isNotEmpty) {
            car.isFav = true;
            car.favId = favs[0].id;
          }

          DocumentSnapshot storesDocumentSnapshot = await stores
              .doc(car.storeId!)
              .get();

          Store store = Store();
          store.id = storesDocumentSnapshot.id;
          store.name = storesDocumentSnapshot.get('name');
          store.logo = storesDocumentSnapshot.get('logo');
          store.phone = storesDocumentSnapshot.get('phone');
          store.state = storesDocumentSnapshot.get('state');

          data.add(ProductsData(car, store));          
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
    favQuerySnapshot = await favoriteCars
        .where('userId',
        isEqualTo:
        appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID))
        .get();
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
    favoriteCars = firestore.collection('favoriteCars');
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