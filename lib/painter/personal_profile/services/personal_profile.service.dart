import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class PersonalProfileService {
  // update password
  static Future<OperationResult<Map<String, dynamic>>> updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    Map<String, dynamic> body = {
      "password": newPassword,
    };
    return await DioApiService().post<Map<String, dynamic>>(
      EndpointServices.getApiEndpoint(EndpointsNames.updatePassword).url,
      body,
      dataKey: 'data',
      context: context,
      allData: true,
    );
  }

  // Activate 2fa
  static Future<OperationResult<Map<String, dynamic>>> activateTfa(
      {required BuildContext context}) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.activateTfa).url;
    return await DioApiService().post<Map<String, dynamic>>(
        url, {"type": "activate", "tfa": "1"},
        context: context, dataKey: 'data', allData: true);
  }

  // Update Profile
  static Future<OperationResult<Map<String, dynamic>>> updateProfile({
    String? name,
    String? email,
    String? emailUuid,
    String? emailCode,
    String? countryKey,
    String? phoneCode,
    String? phone,
    String? phoneUuid,
    String? birthDay, // Format should be "YYYY-MM-DD"
    FilePickerResult? avatar,
    required BuildContext context,
  }) async {
    // Prepare request data
    Map<String, String> requestData = {};
    if (name != null) requestData['name'] = name;
    if (email != null) requestData['email'] = email;
    if (emailUuid != null) requestData['email_uuid'] = emailUuid;
    if (phoneUuid != null) requestData['phone_uuid'] = phoneUuid;
    if (emailCode != null) requestData['email_code'] = emailCode;
    if (countryKey != null) requestData['country_key'] = countryKey;
    if (phoneCode != null) requestData['phone_code'] = phoneCode;
    if (phone != null) requestData['phone'] = phone;
    if (birthDay != null) requestData['birth_day'] = birthDay;

    // Prepare files
    List<FilePickerResult> files = [];
    if (avatar != null) {
      files.add(avatar);
    }

    // Send request
    return await DioApiService().postWithFormData<Map<String, dynamic>>(
      EndpointServices.getApiEndpoint(EndpointsNames.updateInfo).url,
      context: context,
      requestData,
      files: files,
      fileFieldName: 'avatar',
      dataKey: 'data',
      allData: true,
    );
  }

  // Logout
  static Future<OperationResult<void>> logout({
    required BuildContext context,
  }) async {
    return await DioApiService().post<void>(
        EndpointServices.getApiEndpoint(EndpointsNames.logOut).url, {},
        context: context, allData: true, dataKey: 'data');
  }

  // Delete Account
  static Future<OperationResult<void>> removeAccount({
    required BuildContext context,
    required String password,
  }) async {
    return await DioApiService().postWithFormData<void>(
        EndpointServices.getApiEndpoint(EndpointsNames.removeAccount).url,
        {'password': password},
        context: context,
        allData: true,
        dataKey: 'data',
        files: []);
  }
}
