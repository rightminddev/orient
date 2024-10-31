import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/post/data/models/comments_model/get_comment_model.dart';
import 'package:orient/painter/post/data/repositories/comment_repository/comment_repository.dart';

import '../../data/models/comments_model/add_comment_model.dart';
import 'comment_state.dart';



class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.commentRepository) : super(CommentInitialState());

  final CommentRepository commentRepository;
  static CommentCubit get(BuildContext context) => BlocProvider.of(context);

  TextEditingController commentController = TextEditingController();

  GetCommentModel? getCommentModel;
  Future<void> getComment({required String postId}) async {
    emit(GetCommentLoadingState());
    Either<Failure, GetCommentModel> result;
    result = await commentRepository.getComment(postId) ;
    result.fold((failure) {
      print(failure.error);
      emit(GetCommentFailureState(failure.error));
    }, (getCommentModel) {
      this.getCommentModel = getCommentModel;
      emit(GetCommentSuccessState(getCommentModel));
    });
  }


  AddCommentModel? addCommentModel;
  Future<void> addComment({required String postId,required String comment}) async {

    Either<Failure, AddCommentModel> result;
    result = await commentRepository.addComment(postId,comment) ;
    result.fold((failure) {
      print(failure.error);
    }, (addCommentModel) {
      this.addCommentModel = addCommentModel;
      getComment(postId: postId);
    });
  }
}
