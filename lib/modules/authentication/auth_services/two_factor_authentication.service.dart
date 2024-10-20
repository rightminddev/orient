import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../models/operation_result.model.dart';

abstract class TwoFactorAuthenticationService {
  static Future<OperationResult<Map<String, dynamic>>> send2FAVerificationCode(
      {required String uuid,
      required String sendType,
      required BuildContext context}) async {
    final url = '${AppConstants.baseUrl}/rm_users/v1/tfa/$uuid/send';
    return await DioApiService().post<Map<String, dynamic>>(
        context: context,
        url,
        {"send_by": sendType},
        dataKey: 'data',
        allData: true);
  }

  static Future<OperationResult<Map<String, dynamic>>>
      validate2FAVerificationCode(
          {required String uuid,
          required String code,
          required String sendType,
          required BuildContext context,
          required Map<String, dynamic> deviceInformation}) async {
    final url = '${AppConstants.baseUrl}/rm_users/v1/tfa/$uuid/validate';
    return await DioApiService().post<Map<String, dynamic>>(
        url,
        context: context,
        {"send_by": sendType, "code": code, "device_info": deviceInformation},
        dataKey: 'data',
        allData: true);
  }
}
