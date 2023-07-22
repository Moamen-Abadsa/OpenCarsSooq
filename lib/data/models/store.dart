import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String? id;
  String? logo;
  String? vendorId;
  String? name;
  String? phone;
  String? address;
  int? state;
  String? fbLink;
  String? instaLink;
  String? wtLink;
  double? storeRate = 0;

  Store(
      {this.logo,
        this.vendorId,
        this.name,
        this.phone,
        this.address,
        this.state,
        this.fbLink,
        this.instaLink,
        this.wtLink,
        this.storeRate});

  Store.fromJson(QueryDocumentSnapshot json) {
    logo = json['logo'];
    vendorId = json['vendorId'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    fbLink = json['fbLink'];
    instaLink = json['instaLink'];
    wtLink = json['wtLink'];
    storeRate = json['storeRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['vendorId'] = this.vendorId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['state'] = this.state;
    data['fbLink'] = this.fbLink;
    data['instaLink'] = this.instaLink;
    data['wtLink'] = this.wtLink;
    data['storeRate'] = this.storeRate;
    return data;
  }
}
