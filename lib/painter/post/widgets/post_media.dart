import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';

import '../post_model.dart';
import '../show_image_widget.dart';
import '../show_video_widget.dart';

class PostMedia extends StatelessWidget {
  PostMedia({super.key, required this.post,});
  final SocialPost post;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: post.image!.map((item) {
        return Container(
          height: AppSizes.s200,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FullScreenWidget(
            disposeLevel: DisposeLevel.Medium,
            child: ShowImageWidget(index: -1, mediaItem: item.sizes.large,),
          ),
        );

      }).toList(),
    );
  }
}




// else {

// }