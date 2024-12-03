import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class BlogProviderModel extends ChangeNotifier {
  bool isGetBlogLoading = false;
  bool isGetBlogSuccess = false;
  bool hasMoreBlogs = true; // Track if there are more notifications to load
  String? getBlogErrorMessage;
  List blogs = [];
  int currentPage = 1;  // Start with the first page
  final int itemsCount = 9; // Number of items per page

  Future<void> getBlog(BuildContext context) async {
    if (isGetBlogLoading || !hasMoreBlogs) return;

    isGetBlogLoading = true;
    notifyListeners();

    try {
      final response = await DioHelper.getData(
        url: "/blogs/entities-operations?with=tags,category_id",
        context: context,
        query: {
          "itemsCount": itemsCount,
          "page": currentPage,
        },
      );
      final List newBlogs = response.data['data'];
      if (newBlogs.isEmpty) {
        hasMoreBlogs = false;
      } else {
        blogs.addAll(newBlogs);
        currentPage++;
      }
      isGetBlogLoading = false;
      isGetBlogSuccess = true;
      notifyListeners();
    } catch (error) {
      if (error is DioError) {
        getBlogErrorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        getBlogErrorMessage = error.toString();
      }
      isGetBlogLoading = false;
      notifyListeners();
    }
  }
}

