import 'package:dio/dio.dart';


import 'api_services.dart';
import 'end_points.dart';

class ApiServicesImplementation implements ApiServices {
  Dio? _dio;

  ApiServicesImplementation() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    _dio = Dio(baseOptions);
  }

  @override
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    _dio!.options.headers = {
      'Authorization': 'Bearer $token' ?? '',
      'Accept': 'application/json',
      'device-unique-id': EndPoints.deviceId,
    };
    Response data = await _dio!.get(endPoint, queryParameters: queryParameters,);
    return data;
  }

  @override
  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      String? token,
      required Map<String, dynamic>? data}) async {
    _dio!.options.headers = {
      'Authorization': 'Bearer $token' ?? '',
      'Accept': 'application/json',
      'device-unique-id': EndPoints.deviceId,
    };
    return await _dio!.post(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }

  @override
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    _dio!.options.headers = {
      'Authorization': 'Bearer $token' ?? '',
      'Accept': 'application/json',
    };
    return await _dio!.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
