import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pro2/services/cashHelper.dart';

import 'package:dio/dio.dart';
import 'package:pro2/services/cashHelper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api/",
      headers: {"Accept": "application/json"},
    ));
  }

  static Future<Response?> post({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    String? token = CachHelper.getString(key: "token");
    print("Requesting $path with token: $token and data: $data");
    try {
      final response = await dio?.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response data: ${response?.data}");
      return response;
    } on DioException catch (e) {
      print('DioError: ${e.response?.data}');
      print('DioError: ${e.response?.statusCode}');
      print('DioError: ${e.response?.headers}');
      print('DioError: ${e.response?.requestOptions}');
      throw e;
    }
  }
}
















// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:pro2/services/cashHelper.dart';

// class DioHelper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(BaseOptions(
//         baseUrl: "http://10.0.2.2:8000/api/",
//         headers: {"Accept": "application/json"}));
//   }

//   static Future<Response?> get(
//       {required String path, Map<String, dynamic>? query}) async {
//     return await dio?.get(path,
//         queryParameters: query,
//         options: Options(headers: {
//           "Authorization": "Bearer ${CachHelper.getString(key: "token")}"
//         }));
//   }

//   static Future<Response?> post(
//       {required String path,
//       Map<String, dynamic>? query,
//       required Map<String, dynamic> data}) async {
//     return await dio?.post(path,
//         queryParameters: query,
//         data: data,
//         options: Options(headers: {
//           "Authorization": "Bearer ${CachHelper.getString(key: "token")}"
//         }));
//   }
// }
