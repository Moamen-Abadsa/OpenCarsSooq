import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/text_language_keys.dart';
import 'custom_snackbar.dart';

callPhone(String phoneNumber) async {
  if (phoneNumber.isNotEmpty) {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (!await launchUrl(callUrl)) {
      // throw Exception('Could not launch $callUrl');
      showSnackBar(message: phoneNotInstalled.tr);
    }
  } else {
    showSnackBar(message: phoneEmpty.tr);
  }
}