import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';

import 'package:orient/painter/core/errors/failures.dart';

import 'package:orient/painter/post/data/models/comments_model/add_comment_model.dart';

import 'package:orient/painter/post/data/models/comments_model/get_comment_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_points.dart';
import 'comment_repository.dart';

class CommentRepositoryImplementation extends CommentRepository{
  final ApiServices apiServices;
  var context;
  CommentRepositoryImplementation(this.apiServices, this.context);
  @override
  Future<Either<Failure, AddCommentModel>> addComment(String postId, String comment) async{
    var get = Provider.of<AppConfigService>(context, listen: false);
    try {
      print("COMMENT IS => $comment");
      Response data = await apiServices.post(
          endPoint: 'api/social-posts/entities-operations/$postId/comments',
          context: context,
          data: {
            'content' : comment,
          }
      );
      print(data.data);
      print("content == $comment");
      return Right(AddCommentModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GetCommentModel>> getComment(String postId) async{
    var get = Provider.of<AppConfigService>(context, listen: false);
    print("TOKEN IS ---> ${get.token}");
    try {
      Response data = await apiServices.get(
          endPoint: 'api/social-posts/entities-operations/$postId/comments',
          context: context,
        queryParameters: {
          "order_dir" : "desc"
        }
      );
      print(data.data);
      return Right(GetCommentModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

}