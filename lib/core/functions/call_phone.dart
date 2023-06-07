import 'package:url_launcher/url_launcher.dart';

import 'custom_snackbar.dart';

callPhone(String phoneNumber) async {
  if (phoneNumber.isNotEmpty) {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (!await launchUrl(callUrl)) {
      throw Exception('Could not launch $callUrl');
    }
  } else {
    showSnackBar(message: 'this phone Number is empty!');
  }
}