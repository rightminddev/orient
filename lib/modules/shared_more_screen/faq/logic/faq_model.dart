import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/modules/shared_more_screen/faq/logic/get_faq_model.dart';

class FaqModelProvider extends ChangeNotifier{
  bool isLoading = false;
  String? errorMessage;
  FaqModel? faqModel;
  getFaq(context){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
        url: "/rm_page/v1/show?slug=faq",
        context: context,
    ).then((value){
      isLoading = false;
      faqModel = FaqModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
    });
  }
}