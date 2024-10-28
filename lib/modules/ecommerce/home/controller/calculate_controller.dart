import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class CalculateController extends ChangeNotifier{
  bool isProductCalculateLoading = false;
  bool isProductCalculateSuccess = false;
  String? errorProductCalculateMessage;
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
      productsCalculate = value.data['data'];
      isProductCalculateLoading = false;
      isProductCalculateSuccess = true;
      notifyListeners();
    } catch (e) {
      isProductCalculateLoading = false;
      errorProductCalculateMessage = e.toString();
      notifyListeners();
    }
  }
}