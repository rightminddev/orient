import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import 'package:orient/general_services/backend_services/get_endpoint.service.dart';
import 'package:orient/models/endpoint.model.dart';
import 'package:orient/models/operation_result.model.dart';

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
  static Future updateProfile({
    String? name,
    String? email,
    String? emailUuid,
    String? emailCode,
    String? countryKey,
    String? phoneCode,
    String? phone,
    String? phoneUuid,
    String? birthDay, // Format should be "YYYY-MM-DD"
     List<XFile>? avatar,
    required BuildContext context,
  }) async {
    FormData formData = FormData.fromMap(
        {
          if (name != null) 'name' : name,
          if (email != null) 'email' : email,
          if (avatar!.isNotEmpty) "avatar" : avatar != null
        ? await Future.wait(avatar.map((file) async => await MultipartFile.fromFile(file.path, filename: file.name)).toList()) : null,
          if (emailUuid != null) 'email_uuid' : emailUuid,
          if (phoneUuid != null) 'phone_uuid' : phoneUuid,
          if (emailCode != null) 'email_code' : emailCode,
          if (countryKey != null) 'country_key' : countryKey,
          if (phoneCode != null) 'phone_code' : phoneCode,
          if (phone != null) 'phone' : phone,
          if (birthDay != null) 'birth_day' : birthDay,
        }
    );
      DioHelper.postFormData(
        url: "/rm_users/v1/update_profile",
        context: context,
        formdata: formData
    );

    // Send request
    // return await DioApiService().postWithFormData<Map<String, dynamic>>(
    //   EndpointServices.getApiEndpoint(EndpointsNames.updateInfo).url,
    //   context: context,
    //   requestData,
    //   files: files,
    //   fileFieldName: 'avatar',
    //   dataKey: 'data',
    //   allData: true,
    // );
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
