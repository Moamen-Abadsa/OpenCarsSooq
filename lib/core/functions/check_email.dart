import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../localization/text_language_keys.dart';
import 'custom_snackbar.dart';

Future<bool> checkEmail(CollectionReference users, String email) async {
  QuerySnapshot q = await users.where('email', isEqualTo: email).limit(1).get();    
  if(q.docs.isNotEmpty) {
    showSnackBar(message: emailExists.tr);
    return true;
  } else {
    return false;
  }
}