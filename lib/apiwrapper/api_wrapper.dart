import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CallAPI {
  static CallAPI? _callAPI;
  String? baseUrl;
  final Dio dio = Dio();

  static CallAPI get apiMModule => _callAPI!;
  CallAPI.init() {
    if (kDebugMode) {
      print("init() Called!");
      _callAPI ??= CallAPI._init();
    }
  }
  CallAPI._init() {
    if (kDebugMode) {
      print("_init() Called");
      baseUrl = "https://solid-apii.herokuapp.com/";
      print("baseURL Assigned : $baseUrl");
    }
  }

  Future<dynamic> getResponse(String routeName, credentials, header) async {
    try {
      var response = await dio.get('$baseUrl' '$routeName',
          queryParameters: credentials, options: Options(headers: header));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Completed');
          var data = jsonDecode(response.data.toString());
          return data;
        }
      } else {
        if (kDebugMode) {
          print('${response.statusCode} : ${response.data.toString()}');
          throw response.statusCode ?? "Status code not recognized";
        }
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print('Error while fetching data!!! : $error');
      }
    }
  }

  Future<dynamic> postResponse(String routeName, credentials, header) async {
    try {
      var response = await dio.post('$baseUrl' '$routeName',
          data: credentials, options: Options(headers: header));

      if (kDebugMode) {
        print("Headers in response : ${response.headers}");
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Completed');
          var data = response.data;
          return data;
        }
      } else {
        if (kDebugMode) {
          print('${response.statusCode} : ${response.data.toString()}');
          throw response.statusCode ?? "Status code not recognized";
        }
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print('Error while fetching data!!! : $error');
      }
    }
  }
}
