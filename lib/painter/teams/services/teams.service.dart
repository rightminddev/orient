import 'package:flutter/material.dart';
import '../../../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/operation_result.model.dart';

abstract class TeamsService {
  static Future<OperationResult<Map<String, dynamic>>> getTeamDetails({
    required BuildContext context,
    required int teamId,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.showTeam).url}/$teamId';

    //stock/availability
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> getTopRated({
    required BuildContext context,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.topRated).url;
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> createTeam({
    required BuildContext context,
    required String name,
    required String about,
  }) async {
    final String url = EndpointServices.getApiEndpoint(EndpointsNames.team).url;

    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {"name": name, "about": about},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> joinTeam({
    required BuildContext context,
    required int teamId,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.teamJoin).url;

    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {"team_id": teamId},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> approveRequest({
    required BuildContext context,
    required int teamId,
    required int userId,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.teamApproveRequest).url;

    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {"team_id": teamId, "user_id": userId},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> leaveTeam({
    required BuildContext context,
    required int teamId,
    required int newOwnerId,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.leaveTeam).url;

    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {"team_id": teamId, "new_owner_id": newOwnerId},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> deleteUser({
    required BuildContext context,
    required int teamId,
    required int userId,
  }) async {
    final String url =
        EndpointServices.getApiEndpoint(EndpointsNames.deleteMember).url;

    final response = await DioApiService().post<Map<String, dynamic>>(
      url,
      {"team_id": teamId, "user_id": userId},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }

  static Future<OperationResult<Map<String, dynamic>>> updateTeam({
    required BuildContext context,
    required int teamId,
    required String name,
    required String about,
  }) async {
    final String url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.team).url}/$teamId';

    final response = await DioApiService().put<Map<String, dynamic>>(
      url,
      {"name": name, "about": about},
      context: context,
      allData: true,
      dataKey: 'data',
    );
    return response;
  }
}
