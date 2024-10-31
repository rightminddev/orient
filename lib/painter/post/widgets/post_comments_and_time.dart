import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/data/repositories/comment_repository/comment_repository_implementation.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_cubit.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_cubit.dart';
import 'package:orient/painter/post/logic/post_cubit/posts_state.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_body.dart';


class PostCommentAndTime extends StatelessWidget {
   const PostCommentAndTime({super.key, required this.post, required this.socialGroupId, required this.user});
   final User user;
  final SocialPost post;
  final int socialGroupId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit,PostsState>(
      builder: (context, state) {
        return Padding (
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s20, vertical: AppSizes.s15),
          child: Row(
            children: [
              Image.asset(AppImages.messagesImage),
              gapW12,
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    builder: (context) {
                      return  MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CommentCubit(CommentRepositoryImplementation(ApiServicesImplementation()))..getComment(postId: post.id.toString()),
                          ),
                          BlocProvider(create: (context) => PostsCubit(PostRepositoryImplementation(ApiServicesImplementation())),)
                        ],
                        child: StatefulBuilder(builder: (context, setState) {


                          return BottomSheetBody(post: post.id.toString(), socialGroupId: socialGroupId, user: user,);
                        },),
                      );
                    },
                  );
                },
                child: const Text(
                  "Show comments",
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600),
                )
              ),
              const Spacer(),
              const Text(
                "35 min ago",
                style: TextStyle(
                    fontSize: 9,
                    color: Color(0xff9E9898),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
