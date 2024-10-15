import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../general_services/backend_services/api_service/http_api_service/http_api.service.dart';
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
    final response = await HttpApiService().get<Map<String, dynamic>>(
      EndpointServices.getApiEndpoint(EndpointsNames.myStores).url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> getAvailableProducts({
    required BuildContext context,
    int? id,
  }) async {
    final String url = id != null
        ? '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id${EndpointServices.getApiEndpoint(EndpointsNames.avaialbleProducts).url}'
        : '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/:storeId${EndpointServices.getApiEndpoint(EndpointsNames.avaialbleProducts).url}';
    final response = await HttpApiService().get<Map<String, dynamic>>(
      url,
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
    final response = await HttpApiService().post<Map<String, dynamic>>(
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
}
