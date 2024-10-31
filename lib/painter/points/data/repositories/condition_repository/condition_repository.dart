

import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/points/data/models/condition_model.dart';

abstract class ConditionRepository {
  Future<Either<Failure,TermsAndConditionsModel>> getCondition();
}