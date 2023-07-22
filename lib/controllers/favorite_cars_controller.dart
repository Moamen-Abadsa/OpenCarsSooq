import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/class/status_request.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';
import 'package:opencarssooq/core/functions/get_store_car.dart';
import 'package:opencarssooq/core/services/services.dart';

import '../data/models/car.dart';
import '../data/models/products_data.dart';
import '../data/models/store.dart';

abstract class FavoriteCarController extends GetxController {
  Future<String?> addFavCar(String carId);

  removeFavCar(String carId);

  getUserFavorite();
}

class FavoriteCarControllerImp extends FavoriteCarController {
  CollectionReference stores = FirebaseFirestore.instance.collection('stores');
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');

  AppServices appServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  List<ProductsData> carsList = [];

  @override
  Future<String?> addFavCar(String carId) async {
    Map<String, dynamic> carMap = {
      'favorites' : [appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID)]
    };

    cars.doc(carId).update(carMap).whenComplete(() {
      print("Success add fav car");
    }).catchError((error) {
      print("Failed to add fav car: $error");
    });

    return carId;
  }

  @override
  removeFavCar(String docId) {
    cars.doc(docId).update({
      "favorites" : FieldValue.arrayRemove([appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID)])
    }).whenComplete(() {
      print("Success delete fav car");
    }).catchError((error) {
      print("Success delete fav car: $error");
    });
  }

  @override
  getUserFavorite() async {
    statusRequest = StatusRequest.loading;
    update();

    carsList.clear();

    QuerySnapshot carsQuerySnapshot = await cars
        .where('favorites', arrayContains: appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID))
        .get()
        .whenComplete(() {
      statusRequest = StatusRequest.success;
    }).catchError((onError) {
      statusRequest = StatusRequest.failure;
      print('onError getUserFavorite: $onError');
    });

    for(var element in carsQuerySnapshot.docs) {
      Car car = Car.fromJson(element, appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID));

      var c = carsList.firstWhereOrNull((element) => element.store.id! == car.storeId!);
      ProductsData productsData;

      if(c == null) {
        Store store = await getStoreCar(car.storeId!);
        productsData = ProductsData(car, store);
      } else {
        productsData = ProductsData(car, c.store);
      }

      carsList.add(productsData);
    }

    update();
  }

  // @override
  clickHeart(Car car, int index) async {
    if (!car.isFav) {
      car.favId = await addFavCar(car.id!);
    } else {
      removeFavCar(car.favId!);
    }

    car.isFav = !car.isFav;

    carsList.removeAt(index);

    update();
  }

}
