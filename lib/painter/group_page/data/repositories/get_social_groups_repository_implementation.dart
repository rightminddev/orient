import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/group_page/data/models/groups_model.dart';

import '../../../core/api/api_services.dart';
import '../../../core/api/end_points.dart';
import 'get_social_groups_repository.dart';

class GetSocialGroupsRepositoryImplementation extends GetSocialGroupsRepository {
  final ApiServices apiServices;

  GetSocialGroupsRepositoryImplementation(this.apiServices);

  @override
  Future<Either<Failure, GroupResponse>> getSocialGroups() async {
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.postGroups,
          token: EndPoints.token,
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