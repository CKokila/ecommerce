import 'package:flutter/foundation.dart';

class Log {
  static final Log _instance = Log._internal();

  factory Log() {
    return _instance;
  }

  Log._internal() {}

  static void d(String v) {
    if (kDebugMode) {
      print("Ecommerce: $v");
    }
  }
}
