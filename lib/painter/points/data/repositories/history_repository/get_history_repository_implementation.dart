import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/painter/core/api/api_services.dart';

import 'package:orient/painter/core/errors/failures.dart';

import 'package:orient/painter/points/data/models/history_model.dart';

import '../../../../core/api/end_points.dart';
import 'get_history_repository.dart';

class GetHistoryRepositoryImplementation extends GetHistoryRepository {
  final ApiServices apiServices;
  GetHistoryRepositoryImplementation(this.apiServices);
  @override
  Future<Either<Failure, HistoryModel>> getHistory() async{
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.getHistory,
        token: EndPoints.token,
        queryParameters: {
            'device_unique_id': EndPoints.deviceId
        }
      );
      print(data.data);
      return Right(HistoryModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure(error.response!.data['message'].toString()));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

}