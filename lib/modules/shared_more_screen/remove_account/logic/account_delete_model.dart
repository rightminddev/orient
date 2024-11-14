import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:provider/provider.dart';

class AccountDeleteModel extends ChangeNotifier{
 bool isLoading = false;
 bool isDeleteSuccess = false;
 String? errorMessage;
 ValueNotifier<bool> isLoadingWidget = ValueNotifier(false);
 deleteAccount({context, password}){
   isLoading = true;
   isLoadingWidget.value = true;
   notifyListeners();
   DioHelper.postData(
       url: "/rm_users/v1/remove_account",
       context : context,
       data: {
         "password" : password
       }
   ).then((value){
     print(value.data);
     isLoading = false;
     isDeleteSuccess = true;
     isLoadingWidget.value = false;
     notifyListeners();
   }).catchError((error){
     if (error is DioError) {
       errorMessage = error.response?.data['message'] ?? 'Something went wrong';
     } else {
       errorMessage = error.toString();
     }
   });
   isLoading = false;
   isLoadingWidget.value = false;
   notifyListeners();
 }

}