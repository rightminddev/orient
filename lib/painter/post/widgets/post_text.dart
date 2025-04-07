import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';

import '../../../utils/styles.dart';
import '../post_model.dart';

class PostText extends StatelessWidget {
  PostText({super.key, required this.post, });
  final SocialPost post;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20),
      child:Html(
          shrinkWrap: true,
          data: post.content ?? '',
          style: TextsStyles.htmlStyle),
    );
  }
}
