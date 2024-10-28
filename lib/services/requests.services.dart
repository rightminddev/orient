import '../constants/app_sizes.dart';
import '../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../general_services/backend_services/get_endpoint.service.dart';
import '../models/endpoint.model.dart';
import '../models/operation_result.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// used when getting requests ( my requests - my team requests - other Departments requests)
enum GetRequestsTypes { mine, myTeam, otherDepartment, allCompany }

enum RequestStatus {
  waiting,
  waitingSeen,
  seen,
  approved,
  canceled,
  refused,
}

enum RequestManagerActions { approved, refused }

abstract class RequestsServices {
  /// get request Status String from Request Statuses enum
  static String getRequestStatusStr({required RequestStatus status}) {
    switch (status) {
      case RequestStatus.waiting:
        return 'waiting';
      case RequestStatus.waitingSeen:
        return 'waiting_seen';
      case RequestStatus.seen:
        return 'seen';
      case RequestStatus.approved:
        return 'approved';
      case RequestStatus.canceled:
        return 'canceled';
      case RequestStatus.refused:
        return 'refused';
    }
  }

  /// get request type String from GetRequestsTypes
  static String getRequestsTypeStr({required GetRequestsTypes type}) {
    switch (type) {
      case GetRequestsTypes.mine:
        return 'my_requests';
      case GetRequestsTypes.myTeam:
        return 'team_requests';
      case GetRequestsTypes.otherDepartment:
        return 'other_departments';
      case GetRequestsTypes.allCompany:
        return 'all_company_requests';
    }
  }

  /// used in app router configs to get GetRequestTypes from string
  static GetRequestsTypes getRequestTypeFromString(
      {required String? reqTypeString}) {
    switch (reqTypeString) {
      case 'mine':
        return GetRequestsTypes.mine;
      case 'myTeam':
        return GetRequestsTypes.myTeam;
      case 'otherDepartment':
        return GetRequestsTypes.otherDepartment;
      case 'allCompany':
        return GetRequestsTypes.allCompany;
      default:
        return GetRequestsTypes.mine;
    }
  }

  /// get Request Status Icon [waiting_seen - seen - approved - canceled - refused]
  static Icon getRequestsStatusIcon(
      {required BuildContext context,
      String? status,
      Color? iconColor,
      double? iconSize}) {
    switch (status?.toLowerCase().trim()) {
      case 'approved':
        return Icon(Icons.check_circle_outline_rounded,
            color: iconColor ?? Colors.green, size: iconSize ?? AppSizes.s24);
      case 'refused':
        return Icon(Icons.cancel_outlined,
            color: iconColor ?? Colors.red, size: iconSize ?? AppSizes.s24);
      case 'canceled':
        return Icon(Icons.cancel_outlined,
            color: iconColor ?? Colors.yellow, size: iconSize ?? AppSizes.s24);
      case 'seen':
        return Icon(Icons.remove_red_eye_outlined,
            color: iconColor ?? Colors.blue, size: iconSize ?? AppSizes.s24);
      default:
        return Icon(
          Icons.more_horiz,
          color: iconColor ?? Theme.of(context).colorScheme.secondary,
          size: iconSize ?? AppSizes.s24,
        );
    }
  }

  /// build query parameters string
  static String _buildQueryParameters({
    String? requestTypeId,
    List<String>? ids,
    String? from,
    String? to,
    int? plimits,
    int? page,
    String? type,
  }) {
    final Map<String, String> queryParams = {};

    if (requestTypeId != null) queryParams['request_type_id'] = requestTypeId;
    if (ids != null && ids.isNotEmpty) queryParams['emp_ids'] = ids.join(',');
    if (from != null) queryParams['from'] = from;
    if (to != null) queryParams['to'] = to;
    if (plimits != null) queryParams['plimits'] = plimits.toString();
    if (page != null) queryParams['page'] = page.toString();
    if (type != null) queryParams['type'] = type;

    return queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

  /// get Requests depends on the current user privileges
  static Future<OperationResult<Map<String, dynamic>>>
      getRequestsByTypeDependsOnUserPrivileges({
    required BuildContext context,
    required GetRequestsTypes? reqType,
    String? requestTypeId,
    List<String>? empIds,
    String? from,
    String? to,
    int? plimits,
    int? page,
    String? type,
  }) async {
    String baseUrl;
    if (reqType == null) {
      baseUrl =
          '${EndpointServices.getApiEndpoint(EndpointsNames.getRequests).url}}';
    } else {
      baseUrl =
          '${EndpointServices.getApiEndpoint(EndpointsNames.getRequests).url}?type=${getRequestsTypeStr(type: reqType)}';
    }
    final queryParams = _buildQueryParameters(
      requestTypeId: requestTypeId,
      ids: empIds,
      from: from,
      to: to,
      plimits: plimits,
      page: page,
      type: type,
    );
    final url = queryParams.isEmpty ? baseUrl : '$baseUrl&$queryParams';

    final response = await DioApiService().get<Map<String, dynamic>>(url,
        dataKey: 'data', context: context, allData: true);
    return response;
  }

  /// get Requests depends on the current user privileges
  static Future<OperationResult<List<dynamic>>> getSummaryReports({
    required BuildContext context,
    List<String>? years,
    String? requestTypeId,
    String? requestType,
  }) async {
    final baseUrl =
        EndpointServices.getApiEndpoint(EndpointsNames.summaryReport).url;

    // Build query parameters
    final Map<String, String> params = {};
    if (years != null && years.isNotEmpty) {
      params['years'] = years.join(',');
    }
    if (requestTypeId != null) {
      params['request_id'] = requestTypeId;
    }
    if (requestType != null) {
      params['request_type'] = requestType;
    }

    final queryParams =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    final url = queryParams.isEmpty ? baseUrl : '$baseUrl?$queryParams';

    // Send request
    final response = await DioApiService().get<List<dynamic>>(url,
        dataKey: 'data',
        context: context,
        allData: true,
        checkOnTokenExpiration: false);

    return response;
  }

  /// ask remember service
  static Future<OperationResult<Map<String, dynamic>>> askRemember({
    required BuildContext context,
    required String requestId,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.askRemember).url;
    final response = await DioApiService().post<Map<String, dynamic>>(
        url, {'id': requestId},
        context: context, allData: true, dataKey: 'data');
    return response;
  }

  /// ask ignore service
  static Future<OperationResult<Map<String, dynamic>>> askIgnore({
    required BuildContext context,
    required String requestId,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.askIgnore).url;
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {'id': requestId},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  /// method to create a new request with files
  static Future<OperationResult<Map<String, dynamic>>> createNewRequestWithFile(
      {required BuildContext context,
      required Map<String, String> requestData,
      required List<FilePickerResult> files}) async {
    return await DioApiService().postWithFormData<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.empAddRequest).url,
        context: context,
        requestData,
        dataKey: 'data',
        files: files,
        allData: true);
  }

  /// method to create a new request without files
  static Future<OperationResult<Map<String, dynamic>>> createNewRequest(
      {required BuildContext context,
      required Map<String, dynamic> requestData}) async {
    return await DioApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.empAddRequest).url,
        context: context,
        requestData,
        dataKey: 'data',
        allData: true);
  }

  /// method to perform manager action (approve or refuse)
  static Future<OperationResult<Map<String, dynamic>>> managerAction({
    required BuildContext context,
    required String requestId,
    required RequestManagerActions action,
    required String replay,
  }) async {
    final url =
        EndpointServices.getApiEndpoint(EndpointsNames.managerAction).url;
    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {
        'request_id': requestId,
        'action':
            action == RequestManagerActions.approved ? 'approved' : 'refused',
        'replay': replay,
      },
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> getEmployeeBalance({
    required BuildContext context,
    required String empId,
  }) async {
    final url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.getEmployeeBalance).url}/$empId';
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      dataKey: 'data',
      allData: true,
    );
    return response;
  }
}
