import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';

class DioHelper{
  static Dio? dio;
  static initail(){

    dio = Dio(
        BaseOptions(
            baseUrl: "https://lab.r-m.dev/api",
            receiveDataWhenStatusError: true,
            headers: {
              'Accept':'application/json',
              // 'Content-Type' : 'multipart/form-data'
              'Content-Type':"application/json"
            }
        )
    );
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }
  static Future<Response> getData({@required url, @required Map<String, dynamic>? query,context, token, Map<String, dynamic>? data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',
    };
    return await dio!.get(url, queryParameters: query, data: data??null );
  }
  static Future<Response> deleteData({@required url, @required Map<String, dynamic>? query, token, data})async{
    dio!.options.headers = {
      'Accept':'application/json',
      'Authorization': 'Bearer $token',
    };

    return await dio!.delete(url, queryParameters: query, data: data??null);
  }
  static Future<Response> postData({ context ,@required url,@required Map<String, dynamic>? query, token, @required Map<String, dynamic>? data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'application/json',
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',

    };
    return await dio!.post(url, queryParameters: query, data: data??null);
  }
  static Future<Response> postFormData({@required url, formdata,@required Map<String, dynamic>? query, token, @required Map<String, dynamic>? data})async{
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',

    };
    return await dio!.post(url, queryParameters: query, data: formdata);
  }

  static Future<Response> postDataSocket({@required url,@required Map<String, dynamic>? query, token, @required Map<String, dynamic>? data})async{
    dio!.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${token}',
    };

    return await dio!.post(url, queryParameters: query, data: data??null);
  }

  static Future<Response> updateData({@required url,@required Map<String, dynamic>? query, token, @required Map<String, dynamic>? data})async{
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    return await dio!.put(url, queryParameters: query, data: data??null);
  }
  static Future<dynamic> uploadImage({File? file, url, token}) async {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    var fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile_pic": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio!.post(url, data: formData);
    return response.data;
  }
}