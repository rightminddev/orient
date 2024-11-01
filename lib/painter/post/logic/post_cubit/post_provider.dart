import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:orient/painter/core/errors/failures.dart';
import '../../data/models/post_response.dart';
import '../../data/repositories/post_repository/post_repository.dart';

enum PostsStatus { initial, loading, success, pagination, failure }

class PostsProvider extends ChangeNotifier {
  final PostRepository postRepository;

  PostsProvider(this.postRepository);

  ScrollController postsScrollController = ScrollController();

  PostsStatus _status = PostsStatus.initial;

  PostsStatus get status => _status;

  PostResponse? _postResponse;

  PostResponse? get postResponse => _postResponse;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void _setStatus(PostsStatus status) {
    _status = status;
    notifyListeners();
  }

  int appointmentCurrentPage = 1;

  scrollListenerPostsData({required int socialGroupId}) {
    postsScrollController.addListener(() {
      if (postsScrollController.position.pixels ==
          postsScrollController.position.maxScrollExtent) {
        if (postResponse != null) {
          if (postResponse!.count > postResponse!.data.length) {
            appointmentCurrentPage++;
            getPosts(notFirst: true, socialGroupId: socialGroupId);
          }
        }
      }
    });
  }

  Future<void> getPosts(
      {bool notFirst = false, required int socialGroupId}) async {
    if (!notFirst) {
      _setStatus(PostsStatus.loading);
    }
    _errorMessage = null;

    Either<Failure, PostResponse> result;
    result = await postRepository.getSocialGroupsPosts(
      page: appointmentCurrentPage,
      socialGroupId: socialGroupId,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.error;
        _setStatus(PostsStatus.failure);
      },
      (response) {
        if (notFirst) {
          _postResponse!.data.addAll(response.data);
        } else {
          _postResponse = response;
        }
        if (notFirst) {
          _setStatus(PostsStatus.pagination);
        } else {
          _setStatus(PostsStatus.success);
        }
      },
    );
  }

// void _scrollListener() {
//   if (postsScrollController.position.pixels == postsScrollController.position.maxScrollExtent) {
//     if (_postResponse != null && _postResponse!.count > _postResponse!.data.length) {
//       appointmentCurrentPage++;
//       getPosts(notFirst: true, socialGroupId: _postResponse!.data[0].socialGroupId);
//     }
//   }
// }
//
// @override
// void dispose() {
//   postsScrollController.removeListener(_scrollListener);
//   postsScrollController.dispose();
//   super.dispose();
// }
}
