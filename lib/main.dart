import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/services/services.dart';
import 'package:opencarssooq/routes.dart';

import 'app_data_bindings.dart';
import 'core/constant/app_route.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const OpenCarsSooqApp());
}

class OpenCarsSooqApp extends StatelessWidget {
  const OpenCarsSooqApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());

    return GetMaterialApp(
      translations: AppTranslation(),
      locale: localController.language,
      title: 'Open Cars Sooq App',
      debugShowCheckedModeBanner: false,
      initialBinding: AppDataBindings(),
      initialRoute: AppRoute.loginScreen,
      getPages: routes,
    );
  }
}
