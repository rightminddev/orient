import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class HomeModelProvider extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 bool isError = false;
 bool _isLoading = false;
 bool? status;
 bool gif = false;
 String? errorMessage = '';
 void startLoading() {
   _isLoading = true;
   notifyListeners();
   Timer(const Duration(seconds: 2), () {
     _isLoading = false;
     gif = true;
     stopCoinGif();
     notifyListeners();
   });
 }

 stopCoinGif() {
   return Timer(const Duration(seconds: 5), () {
     gif = false;
     notifyListeners();
   });
 }
  addRedeemGift({serial, context}){
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_pointsys/v1/redeem_gift_card",
        context: context,
        data: {
          "serial" : serial.replaceAll('-', '')
        }
    ).then((value){
      print(value.data);
      status = value.data['status'];
      if(value.data['status'] == false){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            AlertsService.error(
                context: context,
                message: value.data['message'],
                title: AppStrings.failed.tr()
            );
          }
        });
      }
      if(value.data['status'] == true){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            AlertsService.success(
                context: context,
                message: "${value.data['message']}",
                title: AppStrings.success.tr()
            );
          }
        });
      }
      isLoading = false;
      errorMessage = value.data['message'];
      isSuccess = true;
      notifyListeners();
    }).catchError((e){
      isError = true;
      errorMessage = e.toString();
      print("ERROR--> $errorMessage");
      notifyListeners();
    });
  }
}