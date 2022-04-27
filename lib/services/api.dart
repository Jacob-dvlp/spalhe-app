import 'package:dio/dio.dart';

Dio api = APIConfigure().connect();

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class APIConfigure {
  static String baseURL =
      isProduction ? "https://api.spalhe.com" : 'http://0.0.0.0:3000';

  Dio connect() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    return Dio(options);
  }
}
