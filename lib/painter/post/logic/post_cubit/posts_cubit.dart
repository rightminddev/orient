import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_state.dart';
import '../../data/models/post_response.dart';
import '../../data/repositories/post_repository/post_repository.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.postRepository) : super(PostsInitialState());

  final PostRepository postRepository;

  static PostsCubit get(BuildContext context) => BlocProvider.of(context);

  bool? isCommented = false;

  void toggleIsCommented() {
    isCommented = true;
    //emit(ToggleIsCommentedState());
  }

  ///

  ScrollController postsScrollController = ScrollController();

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

  PostResponse? postResponse;

  Future<void> getPosts(
      {bool notFirst = false, required int socialGroupId}) async {
    if (notFirst) {
      Either<Failure, PostResponse> result;
      result = await postRepository.getSocialGroupsPosts(
          page: appointmentCurrentPage, socialGroupId: socialGroupId);
      result.fold((failure) {}, (response) {
        postResponse!.data.addAll(response.data);
        emit(GetPostsSuccessState(response));
      });
    } else {
      emit(GetPostsLoadingState());
      Either<Failure, PostResponse> result;
      result = await postRepository.getSocialGroupsPosts(
          page: appointmentCurrentPage, socialGroupId: socialGroupId);
      result.fold((failure) {
        emit(GetPostsFailureState(failure.error));
      }, (response) {
        postResponse = response;
        emit(GetPostsSuccessState(response));
      });
    }
  }
}
