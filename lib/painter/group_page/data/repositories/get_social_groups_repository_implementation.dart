import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/group_page/data/models/groups_model.dart';
import 'package:provider/provider.dart';

import '../../../core/api/api_services.dart';
import '../../../core/api/end_points.dart';
import 'get_social_groups_repository.dart';

class GetSocialGroupsRepositoryImplementation extends GetSocialGroupsRepository {
  final ApiServices apiServices;
  var context;
  GetSocialGroupsRepositoryImplementation(this.apiServices, this.context);

  @override
  Future<Either<Failure, GroupResponse>> getSocialGroups() async {
    var get = Provider.of<AppConfigService>(context, listen: false);
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.postGroups,
          context: context,
          queryParameters: {
            'with': 'posts'
          }
      );
      print(data.data);
      return Right(GroupResponse.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}