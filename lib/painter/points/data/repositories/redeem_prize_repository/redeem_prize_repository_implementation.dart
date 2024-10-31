import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/painter/core/api/api_services.dart';

import 'package:orient/painter/core/errors/failures.dart';

import 'package:orient/painter/points/data/models/redeem_prize_model.dart';
import 'package:orient/painter/points/data/repositories/redeem_prize_repository/redeem_prize_repository.dart';

import '../../../../core/api/end_points.dart';

class RedeemPrizeRepositoryImplementation extends RedeemPrizeRepository {
  final ApiServices apiServices;
  RedeemPrizeRepositoryImplementation(this.apiServices);


  @override
  Future<Either<Failure, RedeemPrizeModel>> redeemPrize({required String prizeName}) async{
    try {
      Response data = await apiServices.post(
          endPoint: EndPoints.postPrize,
          token: EndPoints.token,
          data: {
            'prize' : prizeName,
          }
      );
      print(data.data);
      return Right(RedeemPrizeModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

}