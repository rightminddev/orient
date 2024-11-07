import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';

import '../models/groups_model.dart';

abstract class GetSocialGroupsRepository {
  Future<Either<Failure, GroupResponse>> getSocialGroups();
}