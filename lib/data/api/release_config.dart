import 'package:ecommerce/const/environment.dart';

enum ReleaseMode { debug, test, prod }

class ReleaseConfig {
  static ReleaseMode currentMode = ReleaseMode.debug;

  static String get baseUrl {
    switch (currentMode) {
      case ReleaseMode.debug:
        return Environment.instance.devBaseUrl;
      case ReleaseMode.test:
        return Environment.instance.testBaseUrl;
      case ReleaseMode.prod:
        return Environment.instance.prodBaseUrl;
    }
  }
}
