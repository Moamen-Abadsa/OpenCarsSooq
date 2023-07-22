import 'package:get/get.dart';
import 'package:opencarssooq/core/localization/text_language_keys.dart';

validInput(String value, int min, int max, String type, {String? newValue}) {
  if (value.isEmpty) {
    return requiredValue.tr;
  }
  if (type == "email") {
    if (!GetUtils.isEmail(value)) {
      return emailNotValid.tr;
    }
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(value)) {
      return phoneNotValid.tr;
    }
  }
  if(newValue != null) {
    if(value != newValue) {
      return passwordAndRePasswordNotMatched.tr;
    }
  }
}
