import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/routing/app_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';

class DioHelper{
  static Dio? dio;
  static initail(BuildContext context){
    dio = Dio(
        BaseOptions(
            baseUrl: "https://backend.orient-paints.com/api",
            receiveDataWhenStatusError: true,
            sendTimeout: const Duration(minutes: 2),
            receiveTimeout: const Duration(minutes: 2),
            connectTimeout: const Duration(minutes: 2),
            headers: {
              'Accept':'application/json',
              "lang" : "${CacheHelper.getString("lang")}",

              // 'Content-Type' : 'multipart/form-data'
              'Content-Type':"application/json",

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
    dio!.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          if (error.response?.statusCode == 401) {
            final appConfigService =
            Provider.of<AppConfigService>(context, listen: false);
            appConfigService.logout().then((v){
              context.goNamed(AppRoutes.splash.name,
                  pathParameters: {'lang': context.locale.languageCode});
            });
          }
          return handler.next(error);
        },
      ),
    );
  }
  static Future<Response> getData({@required url, @required Map<String, dynamic>? query,context,lang,  token,bool sendLang = false, Map<String, dynamic>? data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      if(sendLang == true)"Accept-Language" : CacheHelper.getString("lang") ?? "en",
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',
       "lang" : "${CacheHelper.getString("lang")}",
    };
    print("Headers: ${dio!.options.headers}");
    return await dio!.get(url, queryParameters: query );
  }
  static Future<Response> deleteData({@required url, @required Map<String, dynamic>? query, token, data})async{
    dio!.options.headers = {
      'Accept':'application/json',
      'Authorization': 'Bearer $token',
    };

    return await dio!.delete(url, queryParameters: query, data: data??null);
  }
  static Future<Response> postData({ context ,@required url,@required Map<String, dynamic>? query, token, @required data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'application/json',
      "lang" : "${CacheHelper.getString("lang")}",
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',

    };
    return await dio!.post(url, queryParameters: query, data: data??null);
  }
  static Future<Response> putData({ context ,@required url,@required Map<String, dynamic>? query, token, @required Map<String, dynamic>? data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'application/json',
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',
    };
    return await dio!.put(url, queryParameters: query, data: data??null);
  }
  static Future<Response> postFormData({@required url, context, formdata,@required Map<String, dynamic>? query, @required Map<String, dynamic>? data})async{
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'multipart/form-data',
      'device-unique-id' : appConfigServiceProvider.deviceInformation.deviceUniqueId,
      'Authorization': 'Bearer ${appConfigServiceProvider.token}',
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