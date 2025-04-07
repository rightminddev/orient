import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/operation_result.model.dart';
import '../../../services/crud_operation.service.dart';

abstract class PayrollService {
  static String? formatDate(String? dateString) {
    if (dateString == null) return null;

    try {
      // Parse the string into a DateTime object
      DateTime parsedDate = DateTime.parse(dateString);

      // Format the DateTime object into the desired format
      String formattedDate = DateFormat('MMMM yyyy').format(parsedDate);

      return formattedDate;
    } catch (e) {
      // Handle any parsing errors
      return null;
    }
  }

  // Fetch a single Payroll by ID
  static Future<OperationResult<Map<String, dynamic>>> getSinglePayrollById({
    required BuildContext context,
    required String payrollId,
    String? empId,
    List<String>? withValues,
    String? trash,
    String? scope,
    String? page,
    String? departmentId,
    String? fromDate,
    String? toDate,
  }) async {
    // final url =
    //     '${EndpointServices.getApiEndpoint(EndpointsNames.payGetPost).url}?post_id=$id';
    // return await HttpApiService().get<Map<String, dynamic>>(
    //   url,
    //   dataKey: 'data',
    //   context: context,
    //   allData: true,
    // );
    Map<String, dynamic> queryParameters = {};
    if (withValues?.isNotEmpty ?? false) {
      queryParameters['with'] = withValues?.join(',');
    }
    if (trash?.isNotEmpty ?? false) {
      queryParameters['trash'] = trash;
    }
    if (scope?.isNotEmpty ?? false) {
      queryParameters['scope'] = scope;
    }
    if (page?.isNotEmpty ?? false) {
      queryParameters['page'] = page;
    }
    if (departmentId?.isNotEmpty ?? false) {
      queryParameters['department_id'] = departmentId;
    }
    if (empId?.isNotEmpty ?? false) {
      queryParameters['emp_id'] = empId;
    }
    if (fromDate?.isNotEmpty ?? false) {
      queryParameters['from_date'] = fromDate;
    }
    if (toDate?.isNotEmpty ?? false) {
      queryParameters['to_date'] = toDate;
    }
    return await CrudOperationService.readSingleEntityById(
        context: context,
        slug: 'emppayrolls',
        queryParams: queryParameters,
        id: payrollId);
  }

  // Fetch all payrolls
  static Future<OperationResult<Map<String, dynamic>>> getPayrollsList({
    required BuildContext context,
    List<String>? withValues,
    String? trash,
    String? scope,
    String? page,
    String? departmentId,
    String? empId,
    String? fromDate,
    String? toDate,
  }) async {
    // final url = EndpointServices.getApiEndpoint(EndpointsNames.payGetPosts).url;
    // return await HttpApiService().get<Map<String, dynamic>>(
    //   url,
    //   dataKey: 'data',
    //   context: context,
    //   allData: true,
    // );
    Map<String, dynamic> queryParameters = {
      'page': 1,
    };
    if (withValues?.isNotEmpty ?? false) {
      queryParameters['with'] = withValues?.join(',');
    }
    if (trash?.isNotEmpty ?? false) {
      queryParameters['trash'] = trash;
    }
    if (scope?.isNotEmpty ?? false) {
      queryParameters['scope'] = scope;
    }
    if (page?.isNotEmpty ?? false) {
      queryParameters['page'] = page;
    }
    if (departmentId?.isNotEmpty ?? false) {
      queryParameters['department_id'] = departmentId;
    }
    if (empId?.isNotEmpty ?? false) {
      queryParameters['emp_id'] = empId;
    }
    if (fromDate?.isNotEmpty ?? false) {
      queryParameters['from_date'] = fromDate;
    }
    if (toDate?.isNotEmpty ?? false) {
      queryParameters['to_date'] = toDate;
    }

    return await CrudOperationService.readEntities(
        context: context, slug: 'emppayrolls', queryParams: queryParameters);
  }
}
