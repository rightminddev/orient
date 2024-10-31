import 'package:dartz/dartz.dart';
import 'package:orient/painter/post/data/models/post_response.dart';

import '../../../../core/errors/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, PostResponse>> getSocialGroupsPosts(
      {required int page, required int socialGroupId});
}
