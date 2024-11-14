import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BookmarkControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;

  getBookMark(context){
    isLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/:slug/entities-operations/bookmarks",
        context: context,
    );
  }
}