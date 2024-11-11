import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/data/repositories/comment_repository/comment_repository_implementation.dart';
import 'package:orient/painter/post/data/repositories/post_repository/post_repository_implementation.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_provider.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_body.dart';
import 'package:provider/provider.dart';


class PostCommentAndTime extends StatelessWidget {
   PostCommentAndTime({super.key, required this.post, required this.socialGroupId, required this.user});
   final User user;
  final SocialPost post;
  final int socialGroupId;
  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            SvgPicture.asset(AppImages.messageImage),
            gapW12,
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    builder: (context) {
                      return  MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => CommentProvider(CommentRepositoryImplementation(ApiServicesImplementation(), context))..getComment(postId: post.id.toString()),
                          ),
                          ChangeNotifierProvider(create: (context) => PostsProvider(postRepository: PostRepositoryImplementation(ApiServicesImplementation(), context)),)
                        ],
                        child: StatefulBuilder(builder: (context, setState) {


                          return BottomSheetBody(post: post.id.toString(), socialGroupId: socialGroupId, user: user,);
                        },),
                      );
                    },
                  );
                },
                child: Text(
                  AppStrings.showComments.tr(),
                  style: const TextStyle(
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
        );
      },
    );
  }
}
