import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_image_asset.dart';
import '../core/functions/get_store_car.dart';
import '../core/services/services.dart';
import '../data/models/car.dart';
import '../data/models/products_data.dart';
import '../data/models/rated_store.dart';
import '../data/models/store_rating.dart';
import '../data/models/store.dart';
import 'favorite_cars_controller.dart';

abstract class HomeController extends GetxController {
  getTopRatedStores();

  getRecentlyAddedCars();

  clickHeart(Car car);
}

class HomeControllerImp extends HomeController {
  StatusRequest storesStatusRequest = StatusRequest.loading;
  StatusRequest carsStatusRequest = StatusRequest.loading;

  AppServices appServices = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference stores;
  late CollectionReference cars;
  String? userName;

  List<RatedStore> storesList = [];
  List<ProductsData> carsList = [];

  FavoriteCarControllerImp favCarControllerImp = Get.find();

  @override
  getTopRatedStores() async {
    QuerySnapshot querySnapshot = await stores
        .where(
          'storeRate',
          isGreaterThanOrEqualTo: 3.5,
        )
        .orderBy('storeRate', descending: true)
        .get()
        .whenComplete(() => storesStatusRequest = StatusRequest.success)
        .catchError((onError) {
      storesStatusRequest = StatusRequest.failure;
      print('getRecentlyAddedCars: ${onError.toString()}');
    });

    querySnapshot.docs.forEach((element) {
      RatedStore store = RatedStore();
      store.id = element.id;
      store.logo = element.get('logo');
      store.name = element.get('name');
      store.rate = element['storeRate'];

      storesList.add(store);
    });

    update();
  }

  @override
  getRecentlyAddedCars() async {
    QuerySnapshot carsQuerySnapshot = await cars
        .orderBy('actionTime', descending: true)
        // .limit(40)
        .get()
        .whenComplete(() => carsStatusRequest = StatusRequest.success)
        .catchError((onError) {
      carsStatusRequest = StatusRequest.failure;
      print('getRecentlyAddedCars: ${onError.toString()}');
    });

    if (carsQuerySnapshot.docs.isNotEmpty) {
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
    } else {
      carsStatusRequest = StatusRequest.noDataFailure;
    }

    update();
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
  void onInit() {
    stores = firestore.collection('stores');
    cars = firestore.collection('cars');
    userName = appServices.getStringSharedPreferences(SharedPrefKeys.USER_NAME);

    getTopRatedStores();
    getRecentlyAddedCars();
    super.onInit();
  }
}
