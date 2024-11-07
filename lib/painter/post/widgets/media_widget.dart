import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/painter/post/post_details_two.dart';
import 'package:orient/painter/post/post_model.dart';
import 'package:orient/painter/post/show_image_widget.dart';
import 'package:orient/painter/post/show_video_widget.dart';

class MediaWidget extends StatelessWidget {
  late int mediaCount;
  late List<MediaItem> visibleMediaItems;
  final PostModel posts;
  final SocialPost post;

  MediaWidget({required this.posts, super.key, required this.post}) {
    mediaCount = posts.mediaItems.length;
    visibleMediaItems = posts.mediaItems.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.s15),
      ),
      child: _buildMediaGrid(visibleMediaItems, mediaCount,context),
    );
  }

  Widget _buildMediaGrid(
      List<MediaItem> visibleMediaItems, int totalMediaCount,context) {
    if (totalMediaCount == 1) {
      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsTwoScreen(items: posts.mediaItems, post: post,),));
          },
          child: SizedBox(
        height: 200,
          width: double.infinity,
          child: _buildMediaPreview(-1, posts.mediaItems[0])));
    }
    else {
      return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 3,
        mainAxisExtent: 100,
      ),
      itemCount: visibleMediaItems.length,
      itemBuilder: (context, index) {
        MediaItem mediaItem = visibleMediaItems[index];
        if (index == 3 && totalMediaCount > 4) {
          int extraCount = totalMediaCount - 4;
          return GestureDetector(
            onTap: () {},
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildMediaPreview(index, mediaItem), // Show the 4th media item
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(4))),
                  child: Center(
                    child: Text(
                      '+$extraCount',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return GestureDetector(
            onTap: () {}, child: _buildMediaPreview(index, mediaItem));
      },
    );
    }
  }

  Widget _buildMediaPreview(int index, MediaItem mediaItem) {
    if (mediaItem.type == MediaType.image) {
      return ShowImageWidget(index: index, mediaItem: mediaItem.url);
    } else if (mediaItem.type == MediaType.video) {
      return ShowVideoWidget(
        showControls: false,
        post: mediaItem.url,
      );
    }
    return Container();
  }
}