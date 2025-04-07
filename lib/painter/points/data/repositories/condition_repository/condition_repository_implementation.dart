import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/painter/core/api/api_services.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:provider/provider.dart';


import '../../../../core/api/end_points.dart';
import '../../models/condition_model.dart';
import 'condition_repository.dart';

class GetConditionRepositoryImplementation extends ConditionRepository {
  final ApiServices apiServices;
  var context;
  GetConditionRepositoryImplementation(this.apiServices, this.context);
  @override
  Future<Either<Failure, TermsAndConditionsModel>> getCondition() async{
    var get = Provider.of<AppConfigService>(context, listen: false);
    try {
      Response data = await apiServices.get(
          endPoint: EndPoints.conditions,
        context: context,
        queryParameters: {
          'device_unique_id': get.deviceInformation.deviceUniqueId,
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