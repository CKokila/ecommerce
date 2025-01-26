import 'package:flutter/material.dart';

import '../../utils/log.dart';
import '../api/api_response.dart';
import '../api/api_server.dart';

import '../prefs/current_user.dart';

class LoginRepo {
  final DioClient _client;

  final CurrentUser _currentUser = CurrentUser();

  LoginRepo() : _client = DioClient();

  Future<bool> login({var data}) async {
    try {
      ApiResponse response = await _client.post("auth/login", data);
      if (response.status == true) {
        var data = response.data;
        _currentUser.setToken(data['token']);
        return true;
      } else {
        Log.d('Login error ${response.message.toString()}');
        return Future.error(response.message.toString());
      }
    } catch (e) {
      Log.d('Login catch error ${e.toString()}');
      return Future.error(e.toString());
    }
  }
}
