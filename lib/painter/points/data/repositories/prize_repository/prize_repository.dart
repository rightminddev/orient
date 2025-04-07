import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/points/data/models/Prize_model.dart';

import '../../models/copoun_model.dart';

abstract class GetPrizeRepository {
  Future<Either<Failure,PrizeModel>> getPrize();
  Future<Either<Failure,CopounModel>> sendCopoun({required String copounCode});
}