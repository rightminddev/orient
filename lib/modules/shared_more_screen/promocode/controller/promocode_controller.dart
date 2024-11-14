import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:provider/provider.dart';

class PromoCodeControllerModel extends ChangeNotifier{
  bool isLoading = false;
  bool isDeleteSuccess = false;
  String? errorMessage;
  List codes = [];
  getPromos({context}){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
        url: "/ec-discounts/entities-operations",
        context: context,
    ).then((value){
      print(value.data);
      isLoading = false;
      isDeleteSuccess = true;
      codes = value.data['data'];
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
    });
    isLoading = false;
    notifyListeners();
  }

}