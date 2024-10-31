import 'package:orient/painter/post/data/models/comments_model/get_comment_model.dart';

import '../../data/models/comments_model/add_comment_model.dart';
abstract class CommentState {}
class CommentInitialState extends CommentState {}
class GetCommentLoadingState extends CommentState {}
class GetCommentSuccessState extends CommentState {
  final GetCommentModel getCommentModel;
  GetCommentSuccessState(this.getCommentModel);
}
class GetCommentFailureState extends CommentState {
  final String error;
  GetCommentFailureState(this.error);
}


class AddCommentLoadingState extends CommentState {}
class AddCommentSuccessState extends CommentState {
  final AddCommentModel addCommentModel;
  AddCommentSuccessState(this.addCommentModel);
}
class AddCommentFailureState extends CommentState {
  final String error;
  AddCommentFailureState(this.error);
}