import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_snackbar.dart';

Future<bool> checkEmail(CollectionReference users, String email) async {
  QuerySnapshot q = await users.where('email', isEqualTo: email).limit(1).get();    
  if(q.docs.isNotEmpty) {
    showSnackBar(message: 'This email is already exists');
    return true;
  } else {
    return false;
  }
}