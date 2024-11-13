import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class HomeModelProvider extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 bool isError = false;
 bool _isLoading = false;
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
          "serial" : serial
        }
    ).then((value){
      print(value.data);
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