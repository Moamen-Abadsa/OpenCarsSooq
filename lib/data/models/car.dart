class Car {
  String? id;
  String? name;
  String? price;
  String? description;
  String? storeId;
  List<dynamic>? images;
  bool isFav;
  bool hasOffer;
  String? favId;
  String? offerId;
  String? newPrice;
  double? percent;

  Car(
      {this.images,
      this.name,
      this.price,
      this.description,
      this.storeId,
      this.id,
      this.isFav = false,
      this.hasOffer = false,
      this.newPrice,
      this.percent,
      this.favId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['images'] = this.images;
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['isFav'] = this.isFav;
    data['hasOffer'] = this.hasOffer;
    data['favId'] = this.favId;
    data['offerId'] = this.offerId;
    data['newPrice'] = this.newPrice;
    data['percent'] = this.percent;
    return data;
  }
}
