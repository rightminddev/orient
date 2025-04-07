import '../constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../models/operation_result.model.dart';

abstract class CrudOperationService {
  static String _buildQueryParameters(Map<String, dynamic> params) =>
      params.entries.map((e) => '${e.key}=${e.value}').join('&');

  /// Create entity
  /// crudService.createEntity(
  ///   context: context,
  ///   slug: 'rmnotifications',
  ///   data: {'name': 'New Entity'},
  /// );
  static Future<OperationResult<Map<String, dynamic>>> createEntity({
    required BuildContext context,
    required String slug,
    required Map<String, dynamic> data,
  }) async {
    final url = '${AppConstants.baseUrl}/$slug/entities-operations';
    final response = await DioApiService().post<Map<String, dynamic>>(url, data,
        context: context, dataKey: 'data', allData: true);
    return response;
  }

  /// Read entities
  /// crudService.readEntities(
  ///  context: context,
  ///  slug: 'rmnotifications',
  ///  queryParams: {
  ///    'with': 'cate',
  ///    'page': 1,
  ///    'trash': 1,
  ///    'scope': 'filter',
  ///  },
  ///);
  static Future<OperationResult<Map<String, dynamic>>> readEntities({
    required BuildContext context,
    required String slug,
    Map<String, dynamic>? queryParams,
  }) async {
    final queryString = queryParams != null && queryParams.isNotEmpty
        ? '?${_buildQueryParameters(queryParams)}'
        : '';
    final url = '${AppConstants.baseUrl}/$slug/entities-operations$queryString';
    final response = await DioApiService().get<Map<String, dynamic>>(url,
        context: context, allData: true, dataKey: 'data');
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> readSingleEntityById({
    required BuildContext context,
    required String slug,
    required String id,
    Map<String, dynamic>? queryParams,
  }) async {
    final queryString = queryParams != null && queryParams.isNotEmpty
        ? '?${_buildQueryParameters(queryParams)}'
        : '';
    final url =
        '${AppConstants.baseUrl}/$slug/entities-operations/$id$queryString';
    final response = await DioApiService().get<Map<String, dynamic>>(url,
        context: context, allData: true, dataKey: 'data');
    return response;
  }

  /// Update entity [Example]
  /// crudService.updateEntity(
  ///   context: context,
  ///   slug: 'rmnotifications',
  ///   entityId: 'entity_id',
  ///  data: {'name': 'Updated Entity'},
  /// );
  static Future<OperationResult<Map<String, dynamic>>> updateEntity({
    required BuildContext context,
    required String slug,
    required String entityId,
    required Map<String, dynamic> data,
  }) async {
    final url = '${AppConstants.baseUrl}/$slug/entities-operations/$entityId';
    final response = await DioApiService().put<Map<String, dynamic>>(url, data,
        context: context, dataKey: 'data', allData: true);
    return response;
  }

  ///Delete entity [Exmaple]
  /// crudService.deleteEntity(
  ///   context: context,
  ///   slug: 'rmnotifications',
  ///   entityId: 'entity_id',
  /// );
  static Future<OperationResult<Map<String, dynamic>>> deleteEntity({
    required BuildContext context,
    required String slug,
    required String entityId,
  }) async {
    final url = '${AppConstants.baseUrl}/$slug/entities-operations/$entityId';
    final response = await DioApiService().delete<Map<String, dynamic>>(url, {},
        dataKey: 'data', context: context, allData: true);
    return response;
  }
}
