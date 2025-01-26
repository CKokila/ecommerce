enum ReleaseMode { debug, demo, test }

class ReleaseConfig {
  static ReleaseMode currentMode = ReleaseMode.debug;

  static String get baseUrl {
    switch (currentMode) {
      case ReleaseMode.debug:
        return "https://fakestoreapi.com/";
      case ReleaseMode.test:
        return "https://fakestoreapi.com/";
      case ReleaseMode.demo:
        return "https://fakestoreapi.com/";
    }
  }

}
