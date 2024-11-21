import 'package:flutter/cupertino.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BranchControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;

  // getBranches(context){
  //   isLoading = true;
  //   DioHelper.getData(
  //     context: context,
  //       url: url,
  //       query: query
  //   )
  // }
}