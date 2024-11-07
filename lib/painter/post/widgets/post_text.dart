import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';

import '../post_model.dart';

class PostText extends StatelessWidget {
  PostText({super.key, required this.post, });
  final SocialPost post;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(post.content ?? '',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xff464646),
        ),
      ),
    );
  }
}
