class ApiResponse {
  bool status = false;
  dynamic data;
  dynamic error;
  String message = "Something went wrong!";

  ApiResponse(this.status, this.data, this.message, {this.error});

  ApiResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool,
        data = json['data'],
        error = json['error'],
        message = json['message'] as String;

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data,
        'error': error,
        'message': message,
      };
}
