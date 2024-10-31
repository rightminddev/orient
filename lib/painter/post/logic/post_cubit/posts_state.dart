import '../../data/models/post_response.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}
class GetPostsLoadingState extends PostsState {}
class ToggleIsCommentedState extends PostsState {}
class GetPostsSuccessState extends PostsState {
  final PostResponse postResponse;
  GetPostsSuccessState(this.postResponse);
}
class GetPostsFailureState extends PostsState {
  final String error;
  GetPostsFailureState(this.error);
}