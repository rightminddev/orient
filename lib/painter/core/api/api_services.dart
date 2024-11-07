import 'package:dio/dio.dart';

abstract class ApiServices {
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    required context,
  });

  Future<Response> post({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    required context,
    required Map<String, dynamic> data,
  });
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    required context,
    Map<String, dynamic> data,
  });
}
