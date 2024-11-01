import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/image_and_name_section.dart';
import 'package:orient/painter/post/widgets/media_widget.dart';
import 'package:orient/painter/post/widgets/post_comments_and_time.dart';
import 'package:orient/painter/post/widgets/post_media.dart';
import 'package:orient/painter/post/widgets/post_text.dart';
import 'package:orient/painter/post/widgets/post_video.dart';
import 'package:provider/provider.dart';

import '../post_model.dart';
import '../show_image_widget.dart';
import '../show_video_widget.dart';

class CustomSliverList extends StatelessWidget {
  CustomSliverList(
      {super.key, required this.postResponse, required this.socialGroupId});

  final PostResponse postResponse;
  final int socialGroupId;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      childCount: 1,
      (context, index) {
        return Consumer<PostsProvider>(
          builder: (context, provider, child) {
            return Column(
                children: postResponse.data.asMap().entries.map((post) {
                  List<MediaItem> mediaItems = [
                    ...post.value.video.map((e) => MediaItem(
                      url: e.file,
                      type: (MediaType.video),
                    )),
                    ...post.value.image.map((e) => MediaItem(
                      url: e.file,
                      type: (MediaType.image),
                    )),
                  ];
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 23,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.s16),
                              child: Container(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: AppSizes.s20, vertical: AppSizes.s15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(AppSizes.s15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.s20,
                                          vertical: AppSizes.s15),
                                      child: ImageAndNameSection(
                                        user: post.value.user,
                                      ),
                                    ),
                                    gapH16,
                                    PostText(
                                      post: post.value,
                                    ),
                                    MediaWidget(
                                      posts: PostModel(mediaItems: mediaItems),
                                      post: postResponse.data[post.key],
                                    ),
                                    //postResponse.data[index].image != null && postResponse.data[index].image!.isNotEmpty?
                                    // PostMedia(post: postResponse.data[index],)
                                    //     : Container(),
                                    //
                                    //
                                    // postResponse.data[index].video != null && postResponse.data[index].video!.isNotEmpty?
                                    // PostVideo(post: postResponse.data[index],)
                                    //     : Container(),
                                    PostCommentAndTime(
                                      post: postResponse.data[post.key],
                                      socialGroupId: socialGroupId,
                                      user: postResponse.data[post.key].user,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }).toList());
          },
        );

        //fine
        //   Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(20),
        //         topLeft: Radius.circular(20)),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 23,),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16),
        //         child: Container(
        //           // padding: const EdgeInsets.symmetric(
        //           //     horizontal: AppSizes.s20, vertical: AppSizes.s15),
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(AppSizes.s15),
        //           ),
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: AppSizes.s20, vertical: AppSizes.s15),
        //                 child: Row(
        //                   children: [
        //                     Container(
        //                       height: AppSizes.s40,
        //                       width: AppSizes.s40,
        //                       decoration: const BoxDecoration(
        //                         shape: BoxShape.circle,
        //                       ),
        //                       child: ClipOval(
        //                           child: Image.asset(
        //                         AppImages.splashScreenBackground,
        //                         fit: BoxFit.fill,
        //                       )),
        //                     ),
        //                     gapW12,
        //                     Text(
        //                       "Ahmed Muhammed",
        //                       style: TextStyle(fontSize: 15, color: Colors.black),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               gapH16,
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: AppSizes.s20, vertical: AppSizes.s15),
        //                 child: Text(
        //                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
        //                   style: TextStyle(
        //                     fontSize: 11,
        //                     color: Color(0xff464646),
        //                   ),
        //                 ),
        //               ),
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.stretch,
        //                 children: items.map((item) {
        //                   if (item.type == MediaType.image) {
        //                     return Container(
        //                       height: AppSizes.s200,
        //                       padding: EdgeInsets.symmetric(vertical: 8),
        //                       child: FullScreenWidget(
        //                         disposeLevel: DisposeLevel.Medium,
        //                         child: ShowImageWidget(index: -1, mediaItem: item),
        //                       ),
        //                     );
        //                   } else {
        //                     return Container(
        //                         height: AppSizes.s240,
        //                         width: double.infinity,
        //                         padding: EdgeInsets.symmetric(vertical: 8),
        //                         child: Expanded(child: ShowVideoWidget(showControls: true,)));
        //                   }
        //                 }).toList(),
        //               ),
        //               Padding (
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: AppSizes.s20, vertical: AppSizes.s15),
        //                 child: Row(
        //                   children: [
        //                     Image.asset(AppImages.messagesImage),
        //                     gapW12,
        //                     Text(
        //                       "30  -  Show comments",
        //                       style: TextStyle(
        //                           fontSize: 10,
        //                           color: Color(0xff000000),
        //                           fontWeight: FontWeight.w600),
        //                     ),
        //                     Spacer(),
        //                     Text(
        //                       "35 min ago",
        //                       style: TextStyle(
        //                           fontSize: 9,
        //                           color: Color(0xff9E9898),
        //                           fontWeight: FontWeight.w500),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    ));
  }
}
