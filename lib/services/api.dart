import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spalhe/models/auth.dart';

Dio api = new APIConfigure().connect();

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class APIConfigure {
  static final box = GetStorage();
  AuthModel auth = AuthModel.fromJson(box.read('auth') ?? {});

  static String baseURL =
      isProduction ? "https://api.spalhe.com" : 'http://0.0.0.0:3000';

  Dio connect() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {"Authorization": "Bearer ${auth.token}"},
    );

    return Dio(options);
  }
}
