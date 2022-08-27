import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

// New APP
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveDataWhenStatusError: true,
    ));
  }
  // static init() {
  //   dio = Dio(BaseOptions(
  //     baseUrl: "https://student.valuxapps.com/api/",
  //     receiveDataWhenStatusError: true,
  //   ));
  // }

  static Future<Response> postData(
    Map<String, dynamic> query,
    String token, {
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  // Get Data From Api
  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> getDataShop(
    Map<String, dynamic> query,
    String token, {
    required String url,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postDataShop(
    Map<String, dynamic> query,
    String token, {
    String lang = 'en',
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putDataShop(
    Map<String, dynamic> query,
    String token, {
    String lang = 'en',
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.put(url, queryParameters: query, data: data);
  }
}
