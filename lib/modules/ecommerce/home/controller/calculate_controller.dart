import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class CalculateController extends ChangeNotifier{
  bool isProductCalculateLoading = false;
  bool isPostProductCalculateLoading = false;
  bool isProductCalculateSuccess = false;
  bool isPostProductCalculateSuccess = false;
  String? errorProductCalculateMessage;
  String? selectCategory;
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  var calculateResult;
  List productsCalculate = [];
  Future<void> getProductCalculate({required BuildContext context}) async {
    isProductCalculateLoading = true;
    errorProductCalculateMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.getData(
        url: "/rm_ecommarce/v1/product-calculator",
        context: context,
      );
      productsCalculate = value.data['products'];
      isProductCalculateLoading = false;
      isProductCalculateSuccess = true;
      notifyListeners();
    } catch (e) {
      isProductCalculateLoading = false;
      errorProductCalculateMessage = e.toString();
      notifyListeners();
    }
  }
  Future<void> postProductCalculate({required BuildContext context, area, id}) async {
    isPostProductCalculateLoading = true;
    errorProductCalculateMessage = null;
    notifyListeners();
    try {
      var value = await DioHelper.postData(
        url: "/rm_ecommarce/v1/product-calculator",
        context: context,
        data: {
          "product_id" : id,
          "area" : area
        }
      );
      if(value.data['status'] == false){
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        isPostProductCalculateSuccess = true;
        calculateResult = value.data['needed'];
      }
      isPostProductCalculateLoading = false;
      notifyListeners();
    } catch (error) {
      errorProductCalculateMessage = error.toString();
      if (error is DioError) {
        errorProductCalculateMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorProductCalculateMessage = error.toString();
      }
      Fluttertoast.showToast(
          msg: errorProductCalculateMessage!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      isPostProductCalculateLoading = false;
      notifyListeners();
    }
  }
}