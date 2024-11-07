import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';

import '../data/models/post_response.dart';
import '../show_video_widget.dart';

class PostVideo extends StatelessWidget {
  PostVideo({super.key, required this.post});
  final SocialPost post;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: post.video!.map((item) {
        return Container(
            height: AppSizes.s240,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Expanded(child: ShowVideoWidget(showControls: true, post: item.file,)));
      }).toList(),
    );
  }
}
