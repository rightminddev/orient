import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BookmarkControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isLoadingAdd = false;
  bool isSuccessAdd = false;
  bool isSuccess = false;
  String? errorMessage;
  List bookmarks = [];
  getBookMark(context ){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
        url: "/ec-products/entities-operations/bookmarks/list",
        context: context,
    ).then((value){
      isLoading= false;
      isSuccess = true;
      bookmarks = value.data['data'];
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoading= false;
      isSuccess = false;
      notifyListeners();
    });
  }
  addOrRemoveBookMark(context,{id}){
    isLoading = true;
    notifyListeners();
    DioHelper.postData(
      url : "/ec-products/entities-operations/$id/bookmarks",
        data: {
        "action" : "remove"
        },
        context: context,
    ).then((value){
      isLoadingAdd= false;
      isSuccessAdd = true;
      getBookMark(context);
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoadingAdd= false;
      isSuccessAdd = false;
      notifyListeners();
    });
  }
}