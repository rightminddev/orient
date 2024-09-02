import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/http_api_service/http_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class AuthenticationService {
  static Future<OperationResult<Map<String, dynamic>>> login(
      {required String username,
      required String password,
      required Map<String, dynamic> deviceInformation,
      required BuildContext context}) async {
    Map<String, dynamic> body = {
      "username": username, // may be phone number or email
      "password": password,
      "device_info": deviceInformation
    };
    return await HttpApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.createAuthentication)
            .url,
        body,
        dataKey: 'token',
        context: context,
        allData: true);
  }

  static Future<OperationResult<Map<String, dynamic>>> createAccount({
    required String name,
    required String phone,
    required String countryKey,
    required String password,
    required String email,
    required int departmentId,
    required Map<String, dynamic> deviceInformation,
    required BuildContext context,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "email": email,
      "country_key": countryKey,
      "password": password,
      "department_id": departmentId,
      "device_info": deviceInformation
    };
    return await HttpApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.registration).url, body,
        dataKey: 'data', allData: true, context: context);
  }
}
