import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/post_model.dart';
import 'package:orient/painter/post/show_image_widget.dart';
import 'package:orient/painter/post/show_video_widget.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_body.dart';

import 'data/repositories/comment_repository/comment_repository_implementation.dart';
import 'data/repositories/post_repository/post_repository_implementation.dart';
import 'logic/comment_cubit/comment_cubit.dart';
import 'logic/post_cubit/posts_cubit.dart';

class PostDetailsTwoScreen extends StatelessWidget {
  List<MediaItem> items;
  final SocialPost post;
  PostDetailsTwoScreen({required this.items, super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(
        //   "Ahmed Muhammed",
        //   style: TextStyle(fontSize: 15, color: Colors.black),
        // ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
           vertical: AppSizes.s15,
        ),
        child: Container(
          // padding: const EdgeInsets.symmetric(
          //     horizontal: AppSizes.s20, vertical: AppSizes.s15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.s15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s20, vertical: AppSizes.s15),
                child: Row(
                  children: [
                    Container(
                      height: AppSizes.s40,
                      width: AppSizes.s40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: Image.asset(
                        AppImages.splashScreenBackground,
                        fit: BoxFit.fill,
                      )),
                    ),
                    gapW12,
                    Text(
                      post.user.name,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
              gapH16,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s20, vertical: AppSizes.s15),
                child: Text(
                  post.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff464646),
                  ),
                ),
              ),
              gapH12,

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: items.map((item) {
                    if (item.type == MediaType.image) {
                      return Container(
                        height: AppSizes.s200,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: FullScreenWidget(
                          disposeLevel: DisposeLevel.Medium,
                          child: Hero(
                            tag: "smallImage",
                            child: ShowImageWidget(index: -1, mediaItem: item.url),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                          height: AppSizes.s240,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Expanded(
                              child: ShowVideoWidget(
                            showControls: true,
                            post: item.url,
                          )));
                    }
                  }).toList(),
                ),
              ),
              Padding(
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


                                return BottomSheetBody(post: post.id.toString(), socialGroupId: post.socialGroupId, user: post.user,);
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
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
