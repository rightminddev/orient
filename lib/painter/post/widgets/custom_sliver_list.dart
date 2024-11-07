import 'package:flutter/material.dart';
import 'package:orient/painter/post/logic/post_cubit/post_provider.dart';
import 'package:orient/painter/post/widgets/image_and_name_section.dart';
import 'package:orient/painter/post/widgets/media_widget.dart';
import 'package:orient/painter/post/widgets/post_comments_and_time.dart';
import 'package:orient/painter/post/widgets/post_text.dart';
import 'package:provider/provider.dart';
import '../post_model.dart';

class CustomSliverList extends StatelessWidget {
  CustomSliverList({super.key, required this.socialGroupId});

  final int socialGroupId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              // Ensure listPostResponse is not empty
              if (provider.listPostResponse.isEmpty) {
                return Center(child: Text('No posts available.'));
              }

              var post = provider.listPostResponse[index];  // Use updated listPostResponse
              List<MediaItem> mediaItems = [
                ...post.video.map((e) => MediaItem(url: e.file, type: MediaType.video)),
                ...post.image.map((e) => MediaItem(url: e.file, type: MediaType.image)),
              ];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffC9CFD2).withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageAndNameSection(user: post.user),
                        PostText(post: post),
                        MediaWidget(posts: PostModel(mediaItems: mediaItems), post: post),
                        PostCommentAndTime(post: post, socialGroupId: socialGroupId, user: post.user),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: provider.listPostResponse.length,  // Use dynamic length
          ),
        );
      },
    );
  }
}
