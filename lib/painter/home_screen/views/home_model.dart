import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class HomeModelProvider extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 bool isError = false;
 String? errorMessage = '';
  addRedeemGift({serial, context}){
    isLoading = true;
    errorMessage = null;
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
    });
  }
}