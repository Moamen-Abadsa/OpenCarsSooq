import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/class/status_request.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';
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
  CollectionReference favoriteCars =
      FirebaseFirestore.instance.collection('favoriteCars');

  CollectionReference stores = FirebaseFirestore.instance.collection('stores');
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');

  AppServices appServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  List<ProductsData> carsList = [];

  @override
  Future<String?> addFavCar(String carId) async {
    Map<String, dynamic> favCar = {
      'userId': appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID),
      'carId': carId,
      'createdAt': DateTime.now().microsecondsSinceEpoch,
    };

    String? favId;

    await favoriteCars.add(favCar).then((value) {
      print("Success add fav car");
      favId = value.id;
    }).catchError((error) {
      print("Failed to add fav car: $error");
    });

    return favId;
  }

  @override
  removeFavCar(String docId) {
    favoriteCars.doc(docId).delete().then((value) {
      print("Success delete fav car");
    }).catchError((error) {
      print("Failed to delete fav car: $error");
    });
  }

  @override
  getUserFavorite() async {
    statusRequest = StatusRequest.loading;
    update();

    carsList.clear();

    QuerySnapshot favQuerySnapshot = await favoriteCars
        .where('userId', isEqualTo: appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID))
        .get()
        .whenComplete(() {
      statusRequest = StatusRequest.success;
    }).catchError((onError) {
      statusRequest = StatusRequest.failure;
      print('onError getUserFavorite: $onError');
    });

    if(favQuerySnapshot.docs.isEmpty) {
      statusRequest = StatusRequest.success;
      update();
      return;
    }

    QuerySnapshot carsQuerySnapshot = await cars
        .get()
        .whenComplete(() => statusRequest = StatusRequest.success)
        .catchError((onError) {
      statusRequest = StatusRequest.failure;
      print('getUserFavorite cars: ${onError.toString()}');
    });

    for(var element in carsQuerySnapshot.docs) {
      Car car = Car(
          id: element.id,
          name: element['name'],
          price: element['price'],
          description: element['description'],
          images: element['images'],
          storeId: element['storeId']);

      var favs = favQuerySnapshot.docs
          .where((element) => element['carId'] == car.id)
          .toList();

      if (favs.isNotEmpty) {
        car.isFav = true;
        car.favId = favs[0].id;

        DocumentSnapshot storesDocumentSnapshot = await stores
            .doc(car.storeId!)
            .get();

        Store store = Store();
        store.name = storesDocumentSnapshot.get('name');
        store.logo = storesDocumentSnapshot.get('logo');
        store.phone = storesDocumentSnapshot.get('phone');

        carsList.add(ProductsData(car, store));
      }
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
