import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../models/operation_result.model.dart';

abstract class AccountVerificationService {
  static Future<OperationResult<Map<String, dynamic>>> accoutnVerification(
      {required String uuid,
      required String method,
      required BuildContext context}) async {
    final url =
        '${AppConstants.baseUrl}/rm_users/v1/account_verification/$uuid/send';
    final response = await DioApiService().post<Map<String, dynamic>>(
        url,
        {
          "send_by": method,
        },
        dataKey: 'data',
        context: context,
        allData: true);
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>>
      validateAccoutnVerificationCode(
          {required String uuid,
          required String code,
          required String method,
          required Map<String, dynamic> deviceInformation,
          required BuildContext context}) async {
    final url =
        '${AppConstants.baseUrl}/rm_users/v1/account_verification/$uuid/validate';
    final response = await DioApiService().post<Map<String, dynamic>>(
        url,
        {
          "send_by": method,
          "code": int.tryParse(code),
          "device_info": deviceInformation
        },
        dataKey: 'data',
        context: context,
        allData: true);
    return response;
  }
}
