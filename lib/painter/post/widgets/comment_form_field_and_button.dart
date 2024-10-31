import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_cubit.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_state.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_cubit.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_state.dart';

class CommentFormFieldAndButton extends StatelessWidget {
  const CommentFormFieldAndButton(
      {super.key, required this.postId, required this.socialGroupId});

  final String postId;
  final int socialGroupId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
                flex: 1,
                child: TextFormField(
                  controller: CommentCubit.get(context).commentController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
                )),
            const SizedBox(
              width: 15,
            ),
            BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    print(
                        'before toggle${PostsCubit.get(context).isCommented}');
                    CommentCubit.get(context)
                        .addComment(
                            postId: postId,
                            comment: CommentCubit.get(context)
                                .commentController
                                .text)
                        .then((value) {
                      CommentCubit.get(context).commentController.clear();
                      PostsCubit.get(context).scrollListenerPostsData(
                          socialGroupId: socialGroupId);
                      PostsCubit.get(context)
                          .getPosts(socialGroupId: socialGroupId)
                          .then(
                        (value) {
                          PostsCubit.get(context).toggleIsCommented();
                          print(
                              'after toggle${PostsCubit.get(context).isCommented}');
                        },
                      );
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6007E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
