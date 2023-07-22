import 'dart:io';

import 'package:get/get.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/functions/call_phone.dart';
import '../core/functions/open_whatsapp.dart';
import '../core/localization/text_language_keys.dart';

abstract class HelpController extends GetxController {
  Future<void> callToSupportWA();

  Future<void> callToSupportEmail();

  Future<void> callToSupportPhone();
}

class HelpControllerImp extends HelpController {

  @override
  Future<void> callToSupportEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'qf998500@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Hi Support',
        'body': 'I have an issue!!',
      }),
    );
    if (!await launchUrl(emailLaunchUri)) {
      // throw Exception('Could not launch $emailLaunchUri');
      showSnackBar(message: gmailNotInstalled.tr);
    }
  }

  @override
  Future<void> callToSupportPhone() async {
    callPhone('0594326887');
  }

  @override
  Future<void> callToSupportWA() async {
    openWhatsapp(number: '+970594326887', text: 'Hi Support');
  }

}