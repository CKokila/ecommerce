import 'package:flutter/foundation.dart';

class Log {
  static void d(String v) {
    if (kDebugMode) {
      print("Ecommerce: $v");
    }
  }
}

