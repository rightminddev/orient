import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class StoresService {
  /// Get all employees with an optional department ID
  /// EmployeeService.getEmployees(
  ///   context: context,
  ///   departmentId: 'department_id', // optional
  /// );
  static Future<OperationResult<Map<String, dynamic>>> getMyStores({
    required BuildContext context,
  }) async {
    final response = await DioApiService().get<Map<String, dynamic>>(
      EndpointServices.getApiEndpoint(EndpointsNames.myStores).url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> getAvailableProducts({
    required BuildContext context,
    required int id,
    String? search,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id${EndpointServices.getApiEndpoint(EndpointsNames.avaialbleProducts).url}';
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      data: {"search": search},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> updateAvailableProducts({
    required BuildContext context,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id${EndpointServices.getApiEndpoint(EndpointsNames.avaialbleProducts).url}';

    //stock/availability
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      data,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> calculateOrders({
    required BuildContext context,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id${EndpointServices.getApiEndpoint(EndpointsNames.calculateOrder).url}';

    //stock/availability
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      data,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> completeOrders({
    required BuildContext context,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id${EndpointServices.getApiEndpoint(EndpointsNames.completeOrder).url}';

    //stock/availability
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      data,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> addStore({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.myStores).url;

    //stock/availability
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      data,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> updateStore({
    required BuildContext context,
    required Map<String, dynamic> data,
    required int id,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id/update';
//https://lab.r-m.dev/api/rm_ecommarce/v1/stores/3/update
    //stock/availability

    final response = await DioApiService().put<Map<String, dynamic>>(
      url,
      data,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  /// Get specific employee data by ID
  /// EmployeeService.getEmployeeData(
  ///   context: context,
  ///   employeeId: 'employee_id',
  /// );
  static Future<OperationResult<dynamic>> getPlace({
    required BuildContext context,
    required String url,
  }) async {
    final response = await DioApiService.getMapLatAndLong(
      url,
      context,
      // allData: true,
      dataKey: 'data',
    );
    return response;
  }
}
