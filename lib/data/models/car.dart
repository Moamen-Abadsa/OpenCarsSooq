import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Car {
  String? id;
  String? name;
  String? price;
  String? description;
  String? storeId;
  List<dynamic>? images;
  bool isFav = false;
  bool hasOffer = false;
  String? favId;
  String? offerId;
  String? newPrice;
  double? percent;
  List<dynamic>? favorites;
  dynamic offer;

  Car(
      {this.images,
      this.name,
      this.price,
      this.description,
      this.storeId,
      this.id,
      this.favorites,
      this.offer,
      this.isFav = false,
      this.hasOffer = false,
      this.newPrice,
      this.percent,
      this.favId});

  Car.fromJson(QueryDocumentSnapshot json, String userId) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    images = json['images'];
    id = json.id;
    this.storeId = json['storeId'];
    favorites = json['favorites'];
    final favs = favorites!.firstWhereOrNull((element) => element == userId);
    favs != null ? isFav = true : false;
    offer = json['offer'];
    hasOffer = offer != null ? true : false;
    newPrice = offer != null ? offer['newPrice'] : '0';
    percent = offer != null ? offer['percent'] : 0;
    favId = id;
    offerId = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['images'] = this.images;
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['isFav'] = this.isFav;
    data['favorites'] = this.favorites;
    data['offer'] = this.favorites;
    data['hasOffer'] = this.hasOffer;
    data['favId'] = this.favId;
    data['offerId'] = this.offerId;
    data['newPrice'] = this.newPrice;
    data['percent'] = this.percent;
    return data;
  }
}
