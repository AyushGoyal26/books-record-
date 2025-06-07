import 'package:dio/dio.dart';

class ApiClient {
  static Dio createDio(String token) {
    return Dio(
      BaseOptions(
        baseUrl: 'https://readbuddy-server.onrender.com/api',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Add token here
        },
      ),
    );
  }
}
