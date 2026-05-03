import 'package:get/get.dart';

class AppValidator {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterPhone'.tr;
    }

    final phoneRegExp = RegExp(r'^[0-9]+$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'onlyNumbersAllowed'.tr;
    }

    if (value.length != 10) {
      return 'phoneMustBe10Digits'.tr;
    }

    return null;
  }
}
