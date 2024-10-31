import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:orient/painter/core/errors/failures.dart';

import 'package:orient/painter/post/data/models/comments_model/add_comment_model.dart';

import 'package:orient/painter/post/data/models/comments_model/get_comment_model.dart';

import '../../../../core/api/api_services.dart';
import '../../../../core/api/end_points.dart';
import 'comment_repository.dart';

class CommentRepositoryImplementation extends CommentRepository{
  final ApiServices apiServices;

  CommentRepositoryImplementation(this.apiServices);
  @override
  Future<Either<Failure, AddCommentModel>> addComment(String postId, String comment) async{
    try {
      Response data = await apiServices.post(
          endPoint: 'api/social-posts/entities-operations/$postId/comments',
          token: EndPoints.token,
          data: {
            'content' : comment,
          }
      );
      print(data.data);
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
    try {
      Response data = await apiServices.get(
          endPoint: 'api/social-posts/entities-operations/$postId/comments',
          token: EndPoints.token,
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