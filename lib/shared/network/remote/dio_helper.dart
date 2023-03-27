import 'package:dio/dio.dart';

String baseUrl = 'https://student.valuxapps.com/api/';
String contentType = 'application/json';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': contentType,
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': token,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': token,
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': token,
    };
    return dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
