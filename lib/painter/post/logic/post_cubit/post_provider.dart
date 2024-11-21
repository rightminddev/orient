import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import '../../data/models/post_response.dart';
import '../../data/repositories/post_repository/post_repository.dart';

enum PostsStatus { initial, loading, success, pagination, failure }

class PostsProvider extends ChangeNotifier {
  final PostRepository? postRepository;

  PostsProvider({this.postRepository});

  List<SocialPost> listPostResponse = [];
  ScrollController postsScrollController = ScrollController();

  PostsStatus _status = PostsStatus.initial;

  PostsStatus get status => _status;

  PostResponse? _postResponse;

  PostResponse? get postResponse => _postResponse;

  String? _errorMessage;
  bool hasMore = true;
  String? get errorMessage => _errorMessage;
  final ScrollController controller = ScrollController();
  final int expectedPageSize = 9;
  int pageNumber = 1;
  int count = 0;
  ScrollController get scrollController => controller;

  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false; // No more data available if we received less than expected
    } else {
      pageNumber += 1; // Increment for the next page
      return true; // More data available
    }
  }
  void _setStatus(PostsStatus status) {
    _status = status;
    notifyListeners();
  }

  int appointmentCurrentPage = 1;

  Future<void> getPosts({required int socialGroupId, bool isNewPage = false, context}) async {
   // if (_status == PostsStatus.loading || !hasMore) return;
    _setStatus(PostsStatus.loading);
    try {
      final response = await ApiService.getPosts(pageNumber, socialGroupId, context);
      _postResponse = PostResponse.fromJson(response);

      if (isNewPage) {
        listPostResponse.addAll(_postResponse!.data);
      } else {
        listPostResponse = _postResponse!.data;
      }
      hasMore = _postResponse!.data.isNotEmpty;
      if (hasMore) pageNumber++;
      _setStatus(PostsStatus.success);
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      _setStatus(PostsStatus.failure);
      notifyListeners();
    }
  }

  void refreshPosts(int socialGroupId) {
    pageNumber = 1;
    hasMore = true;
    getPosts(socialGroupId: socialGroupId);
  }
  Future<void> addPosts({required int socialGroupId,required context, required List<XFile>? attachments, String? content}) async {
    notifyListeners();
    _setStatus(PostsStatus.loading);
    _errorMessage = null;
    FormData formData = FormData.fromMap({
        "content" : content,
        "social_group_id" : socialGroupId,
       if(attachments != null)"image": attachments != null
          ? await Future.wait(attachments.map((file) async => await MultipartFile.fromFile(file.path, filename: file.name)).toList()) : null,
      });
    DioHelper.postFormData(
        url: "/social-posts/entities-operations/store",
        formdata: formData,
        context: context,
    ).then((value){
      _setStatus(PostsStatus.success);
      PostRepositoryImplementation(ApiServicesImplementation(), context);
      notifyListeners();
    }).catchError((e){
      print("ERROR ---> ${e.toString()}");
      _setStatus(PostsStatus.failure);
      _errorMessage = e.toString();
      notifyListeners();
    });
  }

}
class ApiService {
  static Future<Map<String, dynamic>> getPosts(int pageNumber, int socialGroupId, context) async {
    final response = await DioHelper.getData(
       url:  '/social-posts/entities-operations',
        context: context,
        query: {
      'page': pageNumber,
      'social_group_id': socialGroupId,
      'with': 'social_group_id,user_id',
          "order_dir" : "desc"
    });
    return response.data;
  }
}
