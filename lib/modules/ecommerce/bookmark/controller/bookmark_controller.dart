import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BookmarkControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isLoadingAdd = false;
  bool isSuccessAdd = false;
  bool isSuccess = false;
  bool hasMoreBookmarks = true;
  String? errorMessage;
  List bookmarks = [];
  List newBookmarks = [];
  int currentPage = 1;
  final int itemsCount = 9;
  getBookMark(context ,{page} )async{
    isLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/ec-products/entities-operations/bookmarks/list",
        context: context, // Pass this explicitly only if necessary
        query: {
      "sort":"desc",
          "itemsCount": itemsCount,
          "page": page ?? currentPage,
        },
      );
      print("bookmarks is --> ${bookmarks}");
      newBookmarks = response.data['data'] ?? [];
      if (page == 1) {
        bookmarks.clear(); // Clear only when loading the first page
      }
      if (newBookmarks.isNotEmpty) {
        bookmarks.addAll(newBookmarks);
        currentPage++;
      } else {
        hasMoreBookmarks = false; // No more data to fetch
      }

      isSuccess = true;
    } catch (error) {
      errorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  addOrRemoveBookMark(context,{id, String action = "remove"}){
    isLoadingAdd = true;
    isSuccessAdd = false;
    notifyListeners();
    DioHelper.postData(
      url : "/ec-products/entities-operations/$id/bookmarks",
        data: {
        "action" : action
        },
        context: context,
    ).then((value){
      isLoadingAdd= false;
      isSuccessAdd = true;
      notifyListeners();
      //getBookMark(context);

    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      print("ERROR IS $errorMessage");
      isLoadingAdd= false;
      isSuccessAdd = false;
      notifyListeners();
    });
  }
}