import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_image_asset.dart';
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
  late CollectionReference feedback;
  late CollectionReference stores;
  late CollectionReference cars;
  late CollectionReference favoriteCars;
  String? userName;

  List<RatedStore> storesList = [];
  List<ProductsData> carsList = [];

  FavoriteCarControllerImp favCarControllerImp = Get.find();

  @override
  getTopRatedStores() async {
    QuerySnapshot querySnapshot = await feedback
        .where(
          'rating',
          isGreaterThan: 3,
        )
        .get()
        .whenComplete(() => storesStatusRequest = StatusRequest.success)
        .catchError((onError) {
      storesStatusRequest = StatusRequest.failure;
      print('getRecentlyAddedCars: ${onError.toString()}');
    });

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final element = querySnapshot.docs[i];
      DocumentSnapshot documentSnapshot =
          await stores.doc(element['storeId']).get();

      if (documentSnapshot.exists && storesList.length < 11) {
        String storeId = element['storeId'];
        if (!storesList.any((s) => s.id == storeId)) {
          RatedStore store = RatedStore();
          store.id = storeId;
          store.logo = documentSnapshot.get('logo');
          store.name = documentSnapshot.get('name');
          store.rate = documentSnapshot['storeRate'];

          storesList.add(store);
        }
      } else {
        break;
      }
    }

    update();
  }

  @override
  getRecentlyAddedCars() async {
    QuerySnapshot carsQuerySnapshot = await cars
        .orderBy('actionTime', descending: true)
        .limit(40)
        .get()
        .whenComplete(() => carsStatusRequest = StatusRequest.success)
        .catchError((onError) {
      carsStatusRequest = StatusRequest.failure;
      print('getRecentlyAddedCars: ${onError.toString()}');
    });

    QuerySnapshot favQuerySnapshot = await favoriteCars
        .where('userId',
        isEqualTo:
        appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID))
        .get();

    if (carsQuerySnapshot.docs.isNotEmpty) {
      for (int i = 0; i < carsQuerySnapshot.docs.length; i++) {
        Car car = Car(
            id: carsQuerySnapshot.docs[i].id,
            name: carsQuerySnapshot.docs[i]['name'],
            price: carsQuerySnapshot.docs[i]['price'],
            description: carsQuerySnapshot.docs[i]['description'],
            images: carsQuerySnapshot.docs[i]['images'],
            storeId: carsQuerySnapshot.docs[i]['storeId']);

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

        carsList.add(ProductsData(car, store));
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
    feedback = firestore.collection('feedback');
    stores = firestore.collection('stores');
    cars = firestore.collection('cars');
    favoriteCars = firestore.collection('favoriteCars');
    userName = appServices.getStringSharedPreferences(SharedPrefKeys.USER_NAME);

    getTopRatedStores();
    getRecentlyAddedCars();
    super.onInit();
  }
}
