import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../models/operation_result.model.dart';

abstract class EmployeeService {
  /// Get all employees with an optional department ID
  /// EmployeeService.getEmployees(
  ///   context: context,
  ///   departmentId: 'department_id', // optional
  /// );
  static Future<OperationResult<Map<String, dynamic>>> getEmployees({
    required BuildContext context,
    String? departmentId,
  }) async {
    final String url = departmentId != null
        ? '${AppConstants.baseUrl}/emp_requests/v1/employees?department_id=$departmentId'
        : '${AppConstants.baseUrl}/emp_requests/v1/employees';
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
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
  static Future<OperationResult<Map<String, dynamic>>> getEmployeeData({
    required BuildContext context,
    required String employeeId,
  }) async {
    final String url =
        '${AppConstants.baseUrl}/emp_requests/v1/employees/$employeeId';
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }
}
