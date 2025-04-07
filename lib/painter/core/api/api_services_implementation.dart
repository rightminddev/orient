import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:provider/provider.dart';


import 'api_services.dart';
import 'end_points.dart';

class ApiServicesImplementation implements ApiServices {
  Dio? _dio;

  ApiServicesImplementation() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(baseOptions);
  }

  @override
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    context
  }) async {
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    _dio!.options.headers = {
      'Authorization': 'Bearer ${appConfigServiceProvider.token}' ?? '',
      "lang" : "${CacheHelper.getString("lang")}",
      'Accept': 'application/json',
      'device-unique-id': appConfigServiceProvider.deviceInformation.deviceUniqueId,
    };
    print("TOKENS IS --> ${appConfigServiceProvider.token}");
    print("TOKENS IS --> ${appConfigServiceProvider.deviceInformation.deviceUniqueId}");
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
      "lang" : "${CacheHelper.getString("lang")}",
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
    "lang" : "${CacheHelper.getString("lang")}",
      'device-unique-id': gets.deviceInformation.deviceUniqueId,
    };
    return await _dio!.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
