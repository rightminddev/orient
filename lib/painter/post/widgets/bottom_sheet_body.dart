import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_provider.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/add_new_comment_text.dart';
import 'package:orient/painter/post/widgets/comment_form_field_and_button.dart';
import 'package:orient/painter/post/widgets/comment_text_bottom_sheet.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_edge.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';

import '../data/models/post_response.dart';
import 'comments_list.dart';

class BottomSheetBody extends StatefulWidget {
  BottomSheetBody({super.key, required this.post, required this.socialGroupId, required this.user});
  final User user;
  final String post;
  final int socialGroupId;

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {

  TextEditingController commentController = TextEditingController();
  String selectRate = "4";
  @override
  Widget build(BuildContext context) {
    print('///////////');
    print(widget.post);
    print('///////////');
    return Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          return Consumer<CommentProvider>(
              builder: (context, commentProvider, child) {
                if(commentProvider.isAddCommentSuccess == true){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    commentProvider.getComment(postId: widget.post, context: context);
                  });
                  commentProvider.isAddCommentSuccess = false;
                }
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          const BottomSheetEdge(),
                          const SizedBox(height: 15,),
                          const CommentTextBottomSheet(),
                          const SizedBox(height: 15,),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.55,
                            child: CommentsList(user: widget.user,),
                          ),
                          //Text('data')
                          //SizedBox(height: 15,),
                          const AddNewCommentText(),
                          const SizedBox(height: 10,),
                          Consumer<PostsProvider>(
                            builder: (context, provider, child) {
                              return defaultCommentTextFormField(
                                hintText: AppStrings.typeYourMessage.tr().toUpperCase(),
                                onTapSend: (){
                                  Provider.of<CommentProvider>(context, listen: false).addComment(
                                      context: context,
                                      postId: widget.post,
                                      comment: commentController.text)
                                      .then((value) {
                                    commentController.clear();

                                  });
                                },
                                maxLines: 1,
                                borderColor: const Color(0xffE3E5E5),
                                controller: commentController,
                                viewDropDownRates: true,
                                dropDownValue: selectRate,
                                dropDownOnChanged: (String? value){
                                  setState(() {
                                    selectRate = value!;
                                  });
                                },
                                dropDownItems: ['1', '2', '3', '4', '5'].map((e) {
                                  return DropdownMenuItem(
                                    value: e.toString(),
                                    child: Row(
                                      children: [
                                        Text(
                                          e.toString(),
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1B1B1B)),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xffE6007E),
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                                dropDownHint: Row(
                                  children: [
                                    Text(
                                      "${selectRate.toString()} ",
                                      style:const TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1B1B1B)),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffE6007E),
                                      size: 16,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
          );
        },
    );
  }
}
