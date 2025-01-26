import 'dart:convert';

import 'package:ecommerce/data/prefs/shared_prefs.dart';

class CurrentUser extends Prefs {
  final authToken = "token";
  final tenantId = "tenantId";
  final domain = 'domain';
  final loginFullCredential = "loginFullCredential";
  final customerId = "customerId";

  static final CurrentUser _instance = CurrentUser();

  CurrentUser() {
    Prefs.init();
  }

  static Future<CurrentUser> getInstance() async {
    await Prefs.init();
    return _instance;
  }

  setToken(String value) {
    Prefs.setString(authToken, value);
  }

  String get getToken {
    String v = Prefs.getString(authToken);
    return v;
  }

  String get getLoginDetails {
    String v = Prefs.getString(loginFullCredential);
    return v;
  }

  setCustomerId(String value) {
    Prefs.setString(customerId, value);
  }

  String get getCustomerId {
    var v = Prefs.getString(customerId);
    return v;
  }

  bool get isLogin {
    return getToken.isNotEmpty;
  }

  logout() {}
}
