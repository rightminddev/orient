import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_provider.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:provider/provider.dart';

class CommentFormFieldAndButton extends StatelessWidget {
  CommentFormFieldAndButton(
      {super.key, required this.postId, required this.socialGroupId});

  final String postId;
  final int socialGroupId;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(
                flex: 1,
                child: TextFormField(
                  controller: provider.commentController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.pleaseEnterAComment.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                )),
            SizedBox(
              width: 15,
            ),
            Consumer<PostsProvider>(
              builder: (context, provider, child) {
                return GestureDetector(
                  onTap: () {
                    print("TSP");
                    Provider.of<CommentProvider>(context, listen: false).addComment(
                        postId: postId,
                        comment: Provider.of<CommentProvider>(context, listen: false)
                            .commentController
                            .text)
                        .then((value) {
                          print("TAP");
                      Provider.of<CommentProvider>(context, listen: false).commentController.clear();
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFE6007E),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
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
