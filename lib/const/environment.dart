import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static final Environment _instance = Environment._();

  static Environment get instance => _instance;

  static Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  String get prodBaseUrl => dotenv.env['prodBaseUrl']!;

  String get devBaseUrl => dotenv.env['devBaseUrl']!;

  String get testBaseUrl => dotenv.env['tesBaseUrl']!;
}
