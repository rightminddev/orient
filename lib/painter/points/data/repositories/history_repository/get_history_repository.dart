import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';

import '../../models/history_model.dart';

abstract class GetHistoryRepository {
  Future<Either<Failure,HistoryModel>> getHistory();
}