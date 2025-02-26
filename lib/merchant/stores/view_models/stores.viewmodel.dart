import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/models/available_model.dart';
import 'package:orient/models/products/product_model.dart';
import 'package:orient/models/stores/store_model.dart';
import '../../../models/request/request_model.dart';
import '../services/stores.service.dart';

class StoresViewModel extends ChangeNotifier {
  List<StoreModel> myStores = List.empty(growable: true);
  List<ProductModel> products = List.empty(growable: true);

  RequestModel requestedOrders =
  RequestModel(items: List.empty(growable: true), name: "availabilities");
  String? search;
  String? errorMessage;
  int pageNumber = 1;
  int count = 0;
  bool isLoading = false;
  bool hasMoreData(int length) {
    if (length < count) {
      pageNumber = pageNumber + 1;
      return true;
    } else {
      return false;
    }
  }

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeMyStoresScreen(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getMyStores(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeAvailableProductsScreen(
      BuildContext context, int id) async {
    updateLoadingStatus(laodingValue: true);
    await _getAvailableProducts(context, id);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getMyStores(BuildContext context) async {
    try {
      final result = await StoresService.getMyStores(
        context: context,
        queryParameters: {"page": pageNumber},
      );

      myStores = myStores.isNotEmpty
          ? pageNumber > 1
              ? myStores
              : List.empty(growable: true)
          : List.empty(growable: true);
      if (result.success && result.data != null) {
        count = result.data?['count'];
        (result.data?['stores'] ?? []).forEach((v) {
          myStores.add(StoreModel.fromJson(v));
        });
      }else{
        Fluttertoast.showToast(
            msg: result.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: result.message.toString(),
            title: AppStrings.failed.tr());

     }
      debugPrint(myStores.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _getAvailableProducts(BuildContext context, int id) async {
    try {
      final result = await StoresService.getAvailableProducts(
        context: context,
        id: id,
        search: search,
        queryParameters: {"page": pageNumber},
      );
      products = products.isNotEmpty
          ? pageNumber > 1
              ? products
              : List.empty(growable: true)
          : List.empty(growable: true);

      if (result.success && result.data != null) {
        count = result.data?['count'];
        (result.data?['products'] ?? []).forEach((v) {
          products.add(ProductModel.fromJson(v));
        });
      }else{
        Fluttertoast.showToast(
            msg: result.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: result.message!,
            title: AppStrings.failed.tr());
      }

      debugPrint(products.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
      AlertsService.error(
          context: context,
          message: err.toString(),
          title: AppStrings.failed.tr());
    }
  }
  Future<void> postAvailableProducts(BuildContext context, int id) async {
    isLoading = true;
    notifyListeners();
    await DioHelper.postData(
        url: "/rm_ecommarce/v1/stores/$id/stock/availability",
        context: context,
        data: jsonEncode(requestedOrders.toJson())
    ).then((value){
      isLoading = false;
      if(value.data["status"] == false){
        Fluttertoast.showToast(
            msg: value.data["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        AlertsService.error(
            context: context,
            message: value.data["message"],
            title: AppStrings.failed.tr());
      } if(value.data["status"] == true){
        AlertsService.success(
            context: context,
            message: value.data["message"],
            title: AppStrings.success.tr());
      }
      notifyListeners();
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      print("ERROR IS ---> ${errorMessage}");
    });
  }
}
