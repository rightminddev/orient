import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class ForgotPasswordService {
  /// [FIRST] call [prepareForgetPassword] to get uuid and forget password options.
  static Future<OperationResult<Map<String, dynamic>>> prepareForgetPassword(
      {required String username,
      required String deviceUniqueId,
      required BuildContext context}) async {
    Map<String, dynamic> body = {
      "type": 'prepare',
      "username": username, // may be email or phone number
      "device_unique_id": deviceUniqueId,
    };

    return await DioApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.forgetPassword).url,
        context: context,
        body,
        dataKey: 'data',
        allData: true);
  }

  /// [SECOND] call [forgetPassword] to send uuid and forget password option to get code.
  static Future<OperationResult<Map<String, dynamic>>> forgetPassword(
      {required String username,
      required String sendType,
      required String uuid,
      required BuildContext context,
      required String deviceUniqueId}) async {
    Map<String, dynamic> body = {
      "send_type": sendType,
      "uuid": uuid,
      "type": 'forgot',
      "username": username, // may be email or phone number
      "device_unique_id": deviceUniqueId,
    };

    return await DioApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.forgetPassword).url,
        context: context,
        body,
        dataKey: 'data',
        allData: true);
  }

  /// [FINALLY] call [codeNewPassword] to send code and new password.
  static Future<OperationResult<Map<String, dynamic>>> codeNewPassword(
      {required String code,
      required String newPassword,
      required String username,
      required String sendType,
      required String uuid,
      required BuildContext context,
      required String deviceUniqueId}) async {
    Map<String, dynamic> body = {
      "username": username, // may be email or phone number
      "send_type": sendType,
      "uuid": uuid,
      "code": code,
      "password": newPassword,
      "device_unique_id": deviceUniqueId,
      "type": 'code',
    };

    return await DioApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.forgetPassword).url,
        body,
        context: context,
        dataKey: 'data',
        allData: true);
  }
}
