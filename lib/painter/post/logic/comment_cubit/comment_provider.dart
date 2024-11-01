import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
  String? get errorMessage => _errorMessage;

  void _setStatus(CommentStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> getComment({required String postId}) async {
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

  Future<void> addComment({required String postId, required String comment}) async {
    Either<Failure, AddCommentModel> result = await commentRepository.addComment(postId, comment);

    result.fold(
          (failure) {
        _errorMessage = failure.error;
        _setStatus(CommentStatus.failure);
      },
          (addCommentModel) {
        _addCommentModel = addCommentModel;
        getComment(postId: postId);  // Refresh comments after adding
      },
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
