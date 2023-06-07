import 'package:get/get.dart';

validInput(String value, int min, int max, String type, {String? newValue}) {
  // if (type == "username") {
  //   if (!GetUtils.isUsername(value)) {
  //     return "اسم مستخدم غير صالح";
  //   }
  // }
  //
  // if (type == "email") {
  //   if (!GetUtils.isEmail(value)) {
  //     return "not valid email";
  //   }
  // }
  //
  // if (type == "phone") {
  //   if (!GetUtils.isPhoneNumber(value)) {
  //     return "not valid phone";
  //   }
  // }
  if (value.isEmpty) {
    return "هذا الحقل لا يمكن أن تكون فارغ";
  }

  // if (value.length < min) {
  //   return "لا يمكن أن يكون أقل من $min";
  // }

  // if (value.length > max) {
  //   return "لا يمكن أن يكون أكبر من $max";
  // }

  if(newValue != null) {
    if(value != newValue) {
      return "لا تطابق كلمة المرور";
    }
  }
}
