import 'package:dio/dio.dart';
import 'package:ecommerce/data/api/release_config.dart';
import 'package:flutter/foundation.dart';
import '../../utils/log.dart';
import '../prefs/current_user.dart';
import 'api_response.dart';
import 'exception.dart';

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = ReleaseConfig.baseUrl;
  final CurrentUser _currentUser = CurrentUser();
  final bool _enableLog = kDebugMode;
  String tokenMsg = "Token Refreshing";

  DioClient();

  Future<ApiResponse> login(String url, {required var userCredential}) async {
    try {
      _log("--> POST $url");
      _log("--> POST Data $userCredential");
      Response rawResponse =
          await _dio.post(_baseUrl + url, data: userCredential);
      var response = rawResponse.data;
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success");
        } else {
          return ApiResponse(true, {}, "Success");
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        final errorMessage = DioExceptions.fromDioError(e).toString();
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }

  Future<ApiResponse> get(String url,{Map<String, dynamic>? queryParameters}) async {
    _dio.options.headers = _getHeaders();
    try {
      _log("--> GET $url");
      Response rawResponse = await _dio.get(_baseUrl + url,queryParameters: queryParameters);
      var response = rawResponse.data;
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success" ?? '');
        } else {
          return ApiResponse(true, {}, "Success" ?? '');
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (e.response?.statusCode == 401) {
          Log.d("Logout calling in Catch GET");
          _kickOut();
          return ApiResponse(false, {}, tokenMsg);
        }
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }

  Future<ApiResponse> post(String url, {dynamic data}) async {
    _dio.options.headers = _getHeaders();
    try {
      _log("--> POST DATA $data");
      _log("--> POST $url");
      Response rawResponse = await _dio.post(_baseUrl + url, data: data);
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success");
        } else {
          return ApiResponse(true, {}, "Success");
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (e.response?.statusCode == 401) {
          Log.d("Logout calling in POST");
          _kickOut();
          return ApiResponse(false, {}, tokenMsg);
        }
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }

  Future<ApiResponse> delete(String url, {dynamic data}) async {
    _dio.options.headers = _getHeaders();
    try {
      _log(data);
      _log("--> DELETE $url");
      Response rawResponse = await _dio.delete(_baseUrl + url, data: data);
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success");
        } else {
          return ApiResponse(true, {}, "Success");
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (e.response?.statusCode == 401) {
          Log.d("Logout calling in POST");
          _kickOut();
          return ApiResponse(false, {}, tokenMsg);
        }
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }

  Future<ApiResponse> put(String url, {dynamic data}) async {
    _dio.options.headers = _getHeaders();
    try {
      _log(data);
      _log("--> PUT $url");
      Response rawResponse = await _dio.put(_baseUrl + url, data: data);
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success");
        } else {
          return ApiResponse(true, {}, "Success");
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (e.response?.statusCode == 401) {
          Log.d("Logout calling in POST");
          _kickOut();
          return ApiResponse(false, {}, tokenMsg);
        }
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }
  Future<ApiResponse> patch(String url, {dynamic data}) async {
    _dio.options.headers = _getHeaders();
    try {
      _log(data);
      _log("--> PUT $url");
      Response rawResponse = await _dio.put(_baseUrl + url, data: data);
      _log(
          "<-- ${rawResponse.requestOptions.method} ${rawResponse.statusCode} ${rawResponse.requestOptions.path}");
      _log(rawResponse.data);
      if (rawResponse.statusCode == 200) {
        var data = rawResponse.data;
        if (data != null && data != '') {
          return ApiResponse(true, data, "Success");
        } else {
          return ApiResponse(true, {}, "Success");
        }
      } else {
        var msg = 'Something went wrong';
        Log.d("Message $msg");
        return ApiResponse(false, {}, msg);
      }
    } on DioException catch (e) {
      try {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        if (e.response?.statusCode == 401) {
          Log.d("Logout calling in POST");
          _kickOut();
          return ApiResponse(false, {}, tokenMsg);
        }
        _log(
            "<-- ${e.requestOptions.method} ${e.response?.statusCode} ${e.requestOptions.path}");
        _log("$errorMessage${e.error}");
        return ApiResponse(false, {}, errorMessage);
      } catch (e) {
        return ApiResponse(false, {}, e.toString());
      }
    }
  }

  _kickOut() async {
    Log.d("Kick-out method");
    _currentUser.logout();
  }

  Map<String, dynamic> _getHeaders() {
    Map<String, dynamic> headers = {};
    return headers;
  }

  _log(dynamic data) {
    if (_enableLog) {
      if (data is Map) {
        Log.d("API_LOG: ${data.toString()}");
      } else {
        Log.d("API_LOG: $data");
      }
    }
  }
}
