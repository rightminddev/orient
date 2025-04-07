import 'package:dartz/dartz.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/points/data/models/redeem_prize_model.dart';


abstract class RedeemPrizeRepository {
  Future<Either<Failure,RedeemPrizeModel>> redeemPrize({required String prizeName});
}