import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/painter/core/api/api_services.dart';
import 'package:orient/painter/core/errors/failures.dart';


import '../../../../core/api/end_points.dart';
import '../../models/condition_model.dart';
import 'condition_repository.dart';

class GetConditionRepositoryImplementation extends ConditionRepository {
  final ApiServices apiServices;
  GetConditionRepositoryImplementation(this.apiServices);
  @override
  Future<Either<Failure, TermsAndConditionsModel>> getCondition() async{
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.conditions,
          token: EndPoints.token,
        queryParameters: {
          'device_unique_id': EndPoints.deviceId,
        },
      );
      print(data.data);
      return Right(TermsAndConditionsModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

}