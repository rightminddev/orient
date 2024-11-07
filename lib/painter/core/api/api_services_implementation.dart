import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:provider/provider.dart';


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
    context
  }) async {
    var gets = Provider.of<AppConfigService>(context, listen: false);
    _dio!.options.headers = {
      'Authorization': 'Bearer ${gets.token}' ?? '',
      'Accept': 'application/json',
      'device-unique-id': gets.deviceInformation.deviceUniqueId,
    };
    Response data = await _dio!.get(endPoint, queryParameters: queryParameters,);
    return data;
  }

  @override
  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
        context,
      required Map<String, dynamic>? data}) async {
    var gets = Provider.of<AppConfigService>(context, listen: false);
    _dio!.options.headers = {
      'Authorization': 'Bearer ${gets.token}' ?? '',
      'Accept': 'application/json',
      'device-unique-id': gets.deviceInformation.deviceUniqueId,
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
    Map<String, dynamic>? data,
    context,
  }) async {
    var gets = Provider.of<AppConfigService>(context, listen: false);
    _dio!.options.headers = {
      'Authorization': 'Bearer ${gets.token}' ?? '',
      'Accept': 'application/json',
      'device-unique-id': gets.deviceInformation.deviceUniqueId,
    };
    return await _dio!.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
