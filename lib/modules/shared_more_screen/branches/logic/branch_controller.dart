import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BranchControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;
  List branches = [];
  getBranches({context, stateId})async{
    isLoading = true;
     await DioHelper.getData(
      context: context,
        url: "/ec-stores/entities-operations",
        query: {
        "state_id" : stateId
        }
    ).then((v){
      isLoading = false;
      isSuccess = true;
      branches = v.data['data'];
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      AlertsService.error(
          context: context,
          message: errorMessage!,
          title: AppStrings.failed.tr());
      isLoading = false;
      notifyListeners();
    });
  }
}