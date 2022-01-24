import 'dart:async';
import 'package:spalhe/controllers/auth/auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// ignore: implementation_imports
import 'package:dio/src/response.dart' as res;
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as form;
// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as multi;

class API {
  static String baseURL = "http://0.0.0.0:3333";
  static api() {
    final AuthController authController = Get.put(AuthController());
    var token = authController.auth != null ? authController.auth['token'] : '';
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    return Dio(options);
  }

  // METODO GET
  static Future get(String url) async {
    try {
      res.Response response = await api().get(url);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  // METODO POST
  static Future post(String url, data) async {
    try {
      res.Response response = await api().post(url, data: data);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  static Future put(String url, data) async {
    try {
      res.Response response = await api().put(url, data: data);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  static Future delete(String url) async {
    try {
      res.Response response = await api().delete(url);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  // UPLOAD FILE
  static Future uploadMultiples(url, file) async {
    try {
      form.FormData formData = form.FormData();
      for (var f in file) {
        formData.files.addAll([
          MapEntry(
            "files[]",
            await multi.MultipartFile.fromFile(
              f['path'],
              filename: f['path'].split('/').last,
              contentType: MediaType('', ''),
            ),
          ),
        ]);
      }
      res.Response response = await api().post(url, data: formData);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }

  static Future upload(url, file, [type]) async {
    try {
      form.FormData formData = form.FormData();
      formData.files.add(
        MapEntry(
          "files[]",
          await multi.MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: type != null
                ? MediaType(type[0], type[1])
                : MediaType('image', 'jpg'),
          ),
        ),
      );
      res.Response response = await api().post(url, data: formData);
      return response;
    } on DioError catch (e) {
      throw e.response?.data;
    }
  }
}
