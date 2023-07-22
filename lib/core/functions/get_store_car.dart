import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/store.dart';

Future<Store> getStoreCar(String storeId) async {
  DocumentSnapshot storesDocumentSnapshot = await FirebaseFirestore.instance.collection('stores').doc(storeId).get();

  Store store = Store();
  store.id = storesDocumentSnapshot.id;
  store.name = storesDocumentSnapshot.get('name');
  store.logo = storesDocumentSnapshot.get('logo');
  store.phone = storesDocumentSnapshot.get('phone');
  store.state = storesDocumentSnapshot.get('state');

  return store;
}