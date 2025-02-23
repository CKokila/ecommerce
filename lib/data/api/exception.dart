import 'package:dio/dio.dart';
late String message;
class DioExceptions implements Exception {

  DioExceptions.fromDioError(DioError dioError){

    switch(dioError.type){
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response?.statusCode, dioError.response?.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      // case DioExceptionType.badCertificate:
      //   message = "Bad Certificate";
      //   break;
      case DioExceptionType.connectionError:
        message = "Connection Error";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Error 400. Unable to process your request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong!';
    }
  }

  @override
  String toString() => message;

}