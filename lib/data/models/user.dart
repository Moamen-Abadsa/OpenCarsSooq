class User {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? password;
  // String? storeId;
  bool? isVendor;

  User({this.name, this.email, this.phone, this.address, this.password, this.isVendor});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    password = json['password'];
    isVendor = json['isVendor'];
    // storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['password'] = this.password;
    data['isVendor'] = this.isVendor;
    // data['storeId'] = this.storeId;
    return data;
  }
}
