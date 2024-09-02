import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/http_api_service/http_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class GeneralService {
  static Future<OperationResult<Map<String, dynamic>>> getCompanyTreeStructure({
    required BuildContext context,
  }) async {
    final url =
        EndpointServices.getApiEndpoint(EndpointsNames.companyStructure).url;
    final response = await HttpApiService().get<Map<String, dynamic>>(url,
        context: context,
        allData: true,
        dataKey: 'data',
        checkOnTokenExpiration: false);
    return response;
  }
}
