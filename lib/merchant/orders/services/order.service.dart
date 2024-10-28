import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class OrdersService {
  /// Get all employees with an optional department ID
  /// EmployeeService.getEmployees(
  ///   context: context,
  ///   departmentId: 'department_id', // optional
  /// );

  static Future<OperationResult<Map<String, dynamic>>> getMyOrders({
    required BuildContext context,
    required int id,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$id/${EndpointServices.getApiEndpoint(EndpointsNames.myOrders).url}';
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> getOrderDetails({
    required BuildContext context,
    required int storeId,
    required int orderId,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$storeId/${EndpointServices.getApiEndpoint(EndpointsNames.myOrders).url}/$orderId';

    //stock/availability
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> updateOrderStatus({
    required BuildContext context,
    required int orderId,
    required int storeId,
    required String status,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.myStores).url}/$storeId/${EndpointServices.getApiEndpoint(EndpointsNames.myOrders).url}/$orderId?status=$status';
//api/rm_ecommarce/v1/stores/:storeId/orders/:orderId?status=
    //stock/availability

    final response = await DioApiService().patch<Map<String, dynamic>>(
      url,
      null,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }
}
