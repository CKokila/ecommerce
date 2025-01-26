import 'package:flutter/services.dart';

class Validator {
  static FilteringTextInputFormatter inputCharNum = FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]"));
  static FilteringTextInputFormatter inputNum = FilteringTextInputFormatter.allow(RegExp("[0-9\.]"));
  static FilteringTextInputFormatter inputChar = FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"));
  static FilteringTextInputFormatter numFormat = FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}(\.\d{0,2})?'));
  static FilteringTextInputFormatter percentageFormat = FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?'));
  static FilteringTextInputFormatter skuCodeFormat = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9_\-/\$]"));
  static bool isValidEmail(String? email) {
    if (email == null) return false;
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  static bool isValidURL(String? url) {
    String pattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    RegExp regExp = RegExp(pattern);
    if (url == null && url == '') {
      return false;
    } else if (!(regExp.hasMatch(url!))) {
      return false;
    } else {
      return true;
    }
  }
}
