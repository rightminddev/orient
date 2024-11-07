import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';

import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/group_page/data/models/groups_model.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository.dart';
import 'package:provider/provider.dart';

import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_points.dart';

class PostRepositoryImplementation extends PostRepository {
  final ApiServices apiServices;
  var context;
  PostRepositoryImplementation(this.apiServices, this.context);

  @override
  Future<Either<Failure, PostResponse>> getSocialGroupsPosts(
      {required int page, required int socialGroupId}) async {
    var get = Provider.of<AppConfigService>(context, listen: false);
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.postsInGroup,
          context: context,
          queryParameters: {'social_group_id': socialGroupId, 'page': page});
      return Right(PostResponse.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
