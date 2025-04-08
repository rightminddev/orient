import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class HomeModelProvider extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 bool isError = false;
 bool isRequestSent = false; // Prevents duplicate requests
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
 Future<void> addRedeemGift({String? serial, context}) async {
   isLoading = true;
   errorMessage = null;
   notifyListeners();

   try {
     Response value = await DioHelper.postData(
       url: "/rm_pointsys/v1/redeem_gift_card",
       context: context,
       data: {
         "serial": (serial?.contains("-") ?? false) ? serial!.replaceAll('-', '') : serial,
       },
     );

     print(value.data);
     status = value.data['status'];

     if (value.data['status'] == false) {
       if (context.mounted) {
         Fluttertoast.showToast(
           msg: "${value.data['message']}",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0,
         );
       }
     } else if (value.data['status'] == true) {
       if (context.mounted) {
         int secondsShown = 0;
         const interval = Duration(seconds: 3); // Toast.LENGTH_LONG ~3 sec

         Timer.periodic(interval, (timer) {
           if (secondsShown >= 6) {
             timer.cancel();
           } else {
             Fluttertoast.showToast(
               msg: "${value.data['message']}",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 16.0,
             );
             secondsShown += 3;
           }
         });

         isSuccess = true;
       }
     }

     errorMessage = value.data['message'];
   } catch (e) {
     isError = true;
     errorMessage = e.toString();
     print("ERROR--> $errorMessage");
   } finally {
     isLoading = false;
     notifyListeners();
   }

   // Explicitly return void
   return;
 }

}