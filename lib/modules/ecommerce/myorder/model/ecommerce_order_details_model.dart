import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/ecommerce/myorder/model/order_details_model.dart';

class EcommerceOrderDetailsModel extends ChangeNotifier{
  bool isLoading =false;
  String? errorMessage;
  List myOrders = [];
  OrderDetailsModel? orderDetailsModel;
  getMyOrder(context){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
        url: "/rm_ecommarce/v1/cart/my_orders",
        context: context,
    ).then((value){
      print(value.data);
      myOrders = value.data['orders'];
      notifyListeners();
      isLoading = false;
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoading = false;
      notifyListeners();
    });
  }
  getMyOrderDetails(context, id){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
        url: "/rm_ecommarce/v1/cart/my_orders/$id",
        context: context,
    ).then((value){
      print(value.data);
      orderDetailsModel = OrderDetailsModel.fromJson(value.data);
      notifyListeners();
      isLoading = false;
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoading = false;
      notifyListeners();
    });
  }
}