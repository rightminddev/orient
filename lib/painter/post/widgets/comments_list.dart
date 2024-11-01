import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_provider.dart';
import 'package:provider/provider.dart';

import 'comments_item.dart';

class CommentsList extends StatelessWidget {
  CommentsList({super.key, required this.user});
final User user;
  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, provider, child) {
        if (provider.status == CommentStatus.success) {
          if (provider.getCommentModel!.comments!.isNotEmpty) {
            return ListView.separated(
                itemBuilder: (context, index) => CommentsItem(comments: provider.getCommentModel!.comments![index], user: user,),
                separatorBuilder: (context, index) => SizedBox(height: 15,),
                itemCount: provider.getCommentModel!.comments!.length
            );
          }
          else{
            return Center(
              child: Text('No Comments yet'),
            );
          }

        }
        else if (provider.status == CommentStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (provider.status == CommentStatus.failure) {
          return Center(child: Text(provider.errorMessage!));
        }
        else{
          return Container();

        }
      },
    );
  }
}
