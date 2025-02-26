import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/models/get_one_blog_model.dart';

class BlogProviderModel extends ChangeNotifier {
  bool isGetBlogLoading = false;
  bool isGetBlogSuccess = false;
  bool hasMoreBlogs = true; // Track if there are more notifications to load
  String? getBlogErrorMessage;
  GetOneBlogModel? getOneBlogModel;
  List blogs = [];
  List newBlogs = [];
  int currentPage = 1;  // Start with the first page
  final int itemsCount = 9; // Number of items per page
  bool hasMore = true;
  final int expectedPageSize = 9;
  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false;
    } else {
      currentPage += 1;
      return true;
    }
  }

  Future<void> getBlog(BuildContext context, {page}) async {
    if(page != null){currentPage = page;}
    print("currentPage is --> $currentPage}");
    isGetBlogLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/blogs/entities-operations?with=tags,category_id",
        context: context,
        query: {
          "itemsCount": itemsCount,
          "page":page ?? currentPage,
        },
      );

      newBlogs = response.data['data'] ?? [];
      if (page == 1) {
        blogs.clear(); // Clear only when loading the first page
      }
      if (newBlogs.isNotEmpty) {
        blogs.addAll(newBlogs);
        print("LENGTH IS --> ${newBlogs.length}");
        if (hasMore) currentPage++;
      } else {
        hasMoreBlogs = false; // No more data to fetch
      }

      isGetBlogSuccess = true;
    } catch (error) {
      getBlogErrorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isGetBlogLoading = false;
      notifyListeners();
    }
  }
  Future<void> getOneBlog(BuildContext context, {page, id}) async {
    if(page != null){currentPage = page;}
    print("currentPage is --> $currentPage}");
    isGetBlogLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.getData(
        url: "/blogs/entities-operations/$id?with=tags,category_id",
        context: context,
        query: {
          "itemsCount": itemsCount,
          "page":page ?? currentPage,
        },
      );
      isGetBlogLoading = false;
      if(response.data["status"] ==true){
        getOneBlogModel = GetOneBlogModel.fromJson(response.data);
        isGetBlogSuccess = true;
      }else{
        isGetBlogLoading = false;
      }
      notifyListeners();
    } catch (error) {
      getBlogErrorMessage = error is DioError
          ? error.response?.data['message'] ?? 'Something went wrong'
          : error.toString();
    } finally {
      isGetBlogLoading = false;
      notifyListeners();
    }
  }
}

