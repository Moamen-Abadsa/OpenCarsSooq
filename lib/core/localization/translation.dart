import 'package:get/get.dart';
import 'lang_ar.dart';
import 'lang_en.dart';

class AppTranslation extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
      "ar" : arabic,
      "en" : english
  };

}