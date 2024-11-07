import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/post/data/models/comments_model/add_comment_model.dart';

import '../../models/comments_model/get_comment_model.dart';

abstract class CommentRepository{
  Future<Either<Failure,AddCommentModel>> addComment(String postId,String comment);
  Future<Either<Failure,GetCommentModel>> getComment(String postId);
}