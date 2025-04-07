import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/painter/core/api/api_services.dart';

import 'package:orient/painter/core/errors/failures.dart';

import 'package:orient/painter/points/data/models/history_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/api/end_points.dart';
import 'get_history_repository.dart';

class GetHistoryRepositoryImplementation extends GetHistoryRepository {
  final ApiServices apiServices;
  var context;
  GetHistoryRepositoryImplementation(this.apiServices, this.context);
  @override
  Future<Either<Failure, HistoryModel>> getHistory() async{
    var get = Provider.of<AppConfigService>(context, listen: false);
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.getHistory,
        context: context,
        queryParameters: {
            'device_unique_id': get.deviceInformation.deviceUniqueId
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