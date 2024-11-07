import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/logic/comment_cubit/comment_provider.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/post_model.dart';
import 'package:orient/painter/post/show_image_widget.dart';
import 'package:orient/painter/post/show_video_widget.dart';
import 'package:orient/painter/post/widgets/bottom_sheet_body.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../core/api/api_services_implementation.dart';
import 'data/repositories/comment_repository/comment_repository_implementation.dart';
import 'data/repositories/post_repository/post_repository_implementation.dart';


class PostDetailsTwoScreen extends StatelessWidget {
  List<MediaItem> items;
  final SocialPost post;
  PostDetailsTwoScreen({required this.items, super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.s15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(''),
                      IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                          onPressed: (){}
                      ),
                    ],
                  ),),
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
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
                    style: TextStyle(
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
                          padding: EdgeInsets.symmetric(vertical: 8),
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
                            padding: EdgeInsets.symmetric(vertical: 8),
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
                      SvgPicture.asset(AppImages.messageImage),
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
                              return  MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                    create: (context) => CommentProvider(CommentRepositoryImplementation(ApiServicesImplementation(), context))..getComment(postId: post.id.toString()),
                                  ),
                                  ChangeNotifierProvider(create: (context) => PostsProvider(postRepository: PostRepositoryImplementation(ApiServicesImplementation(), context)),)
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
      ),
    );
  }
}
