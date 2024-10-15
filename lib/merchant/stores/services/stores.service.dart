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

  /// Get specific employee data by ID
  /// EmployeeService.getEmployeeData(
  ///   context: context,
  ///   employeeId: 'employee_id',
  /// );
}
