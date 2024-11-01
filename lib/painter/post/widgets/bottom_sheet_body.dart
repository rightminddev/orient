import 'package:flutter/material.dart';
import 'package:orient/painter/post/widgets/add_new_comment_text.dart';
import 'package:orient/painter/post/widgets/comment_form_field_and_button.dart';
import 'package:orient/painter/post/widgets/comment_text_bottom_sheet.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_edge.dart';

import '../data/models/post_response.dart';
import 'comments_list.dart';

class BottomSheetBody extends StatelessWidget {
  BottomSheetBody({super.key, required this.post, required this.socialGroupId, required this.user});
  final User user;
  final String post;
  final int socialGroupId;
  @override
  Widget build(BuildContext context) {
    print('///////////');
    print(post);
    print('///////////');
    return SizedBox(
      width: double.infinity,
      height: 1000,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            BottomSheetEdge(),
            SizedBox(height: 15,),
            CommentTextBottomSheet(),
            SizedBox(height: 15,),
            SizedBox(
              height: 670,
              child: CommentsList(user: user,),
            ),
            //Text('data')
            //SizedBox(height: 15,),
            AddNewCommentText(),
            SizedBox(height: 10,),
            CommentFormFieldAndButton(postId: post, socialGroupId: socialGroupId)
          ],
        ),
      ),
    );
  }
}
