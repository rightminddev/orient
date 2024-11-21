import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';

class DeviceControllerProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoading2 = false;
  bool notificationStatus = CacheHelper.getBool("status") ?? false;
  String? errorMessage;
  String? errorMessage2;
  void setNotificationStatus(bool status) {
    notificationStatus = status;
    notifyListeners();
  }

  getDeviceSysGet({context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.postData(
        url: "/rm_users/v1/device_sys",
        context: context,
        data: {
          "action": "get",
          "key": "notification_token_status",
        },
      );
      isLoading = false;
      notificationStatus = response.data['device']['notification_token_status'] == 1 ? true : false;
      print("notificationStatus --> $notificationStatus");
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
    }
  }

  getDeviceSysSet({context, required bool state}) async {
    isLoading2 = true;
    notifyListeners();
    try {
      final response = await DioHelper.postData(
        url: "/rm_users/v1/device_sys",
        context: context,
        data: {
          "action": "set",
          "key": "notification_token_status",
          "value": state,
        },
      );
      isLoading2 = false;
      notificationStatus = state;
      print("state---$state");
      CacheHelper.setBool("status", state);
      print("STATUS IS ---> ${CacheHelper.getBool("status")}");
      notifyListeners();
    } catch (error) {
      isLoading2 = false;
      notifyListeners();
      if (error is DioError) {
        errorMessage2 = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage2 = error.toString();
      }
    }
  }
}
