import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_state.dart';

import '../logic/comment_cubit/comment_cubit.dart';
import 'comments_item.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.user});
final User user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit,CommentState>(
      builder: (context, state) {
        if (state is GetCommentSuccessState) {
          if (CommentCubit.get(context).getCommentModel!.comments!.isEmpty) {
            return const Center(child: Text('No comments yet'));
          }
          else{
            return ListView.separated(
                itemBuilder: (context, index) => CommentsItem(comments: CommentCubit.get(context).getCommentModel!.comments![index], user: user,),
                separatorBuilder: (context, index) => const SizedBox(height: 15,),
                itemCount: CommentCubit.get(context).getCommentModel!.comments!.length
            );
          }
        }
        else if (state is GetCommentFailureState) {
          return const Center(child: Text('Something went wrong, try again'));
        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
