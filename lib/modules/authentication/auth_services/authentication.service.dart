import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
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
    return await DioApiService().post<Map<String, dynamic>>(
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
    required String registerAs,
    required int departmentId,
    var nationalId,
    var assignedBy,
    var countryId,
    var stateId,
    var locationAddress,
    var cityId,
    var birthDay,
    required Map<String, dynamic> deviceInformation,
    required BuildContext context,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "birth_day" : birthDay,
     if(email != "" && email != null) "email": email,
      if(locationAddress != "" && locationAddress != null)  "location_address" : locationAddress,
      "register_as" : registerAs,
      "country_key": countryKey,
      "password": password,
     if(nationalId != "" &&nationalId != null) "national_id": nationalId,
      if(assignedBy != "" && assignedBy != null) "assigned_by": assignedBy,
      if(countryId != "" && countryId != null) "country_id": countryId,
      if(stateId != "" && stateId != null) "state_id": stateId,
      if(cityId != "" && cityId != null) "city_id": cityId,
      "department_id": departmentId,
      "device_info": deviceInformation
    };
    return await DioApiService().post<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.registration).url, body,
        dataKey: 'data', allData: true, context: context);
  }
  static Future<OperationResult<Map<String, dynamic>>> getDeviceToken({
    required BuildContext context,
  }) async {
    return await DioApiService().get<Map<String, dynamic>>(
        EndpointServices.getApiEndpoint(EndpointsNames.getDeviceToken).url,
        dataKey: 'data',
        allData: true,
        context: context);
  }
}
