import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/text_language_keys.dart';
import 'custom_snackbar.dart';

void openWhatsapp({required String text, required String number}) async {
  if(number.isNotEmpty) {
    var whatsapp = number;
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        showSnackBar(message: whatsNotInstalled.tr);
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        showSnackBar(message: whatsNotInstalled.tr);
      }
    }
  } else {
    showSnackBar(message: whatsNumberEmpty.tr);
  }
}