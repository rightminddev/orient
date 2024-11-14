import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/post/data/models/comments_model/get_comment_model.dart';
import 'package:orient/painter/post/data/models/comments_model/add_comment_model.dart';
import 'package:orient/painter/post/data/repositories/comment_repository/comment_repository.dart';

enum CommentStatus { initial, loading, success, failure }

class CommentProvider extends ChangeNotifier {
  final CommentRepository commentRepository;
  CommentProvider(this.commentRepository);

  TextEditingController commentController = TextEditingController();

  CommentStatus _status = CommentStatus.initial;
  CommentStatus get status => _status;

  GetCommentModel? _getCommentModel;
  GetCommentModel? get getCommentModel => _getCommentModel;

  AddCommentModel? _addCommentModel;
  AddCommentModel? get addCommentModel => _addCommentModel;

  String? _errorMessage;
  bool isAddCommentSuccess = false;
  String? get errorMessage => _errorMessage;

  void _setStatus(CommentStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> getComment({required String postId,  context}) async {
    _setStatus(CommentStatus.loading);
    _errorMessage = null;

    Either<Failure, GetCommentModel> result = await commentRepository.getComment(postId);
    result.fold(
          (failure) {
        _errorMessage = failure.error;
        _setStatus(CommentStatus.failure);
      },
          (getCommentModel) {
        _getCommentModel = getCommentModel;
        _setStatus(CommentStatus.success);
      },
    );
  }

  Future<void> addComment({required String postId, required String comment ,context}) async {
    _setStatus(CommentStatus.loading);
    print("COMMENT IS --> $comment");
    DioHelper.postData(
        url: "/social-posts/entities-operations/$postId/comments",
        context: context,
        data: {
          'content' : comment,
        }
    ).then((value){
      print(value.data);
      isAddCommentSuccess =true;
      _setStatus(CommentStatus.success);
      _addCommentModel = AddCommentModel.fromJson(value.data);
    }).catchError((error){
      if (error is DioError) {
        _errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        _errorMessage = error.toString();
      }
      _setStatus(CommentStatus.failure);
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
