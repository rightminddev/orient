import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/utils/cached_network_image_widget.dart';
import 'package:orient/utils/media_query_values.dart';

import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../data/models/comments_model/get_comment_model.dart';
class CommentsItem extends StatelessWidget {
  CommentsItem({super.key, required this.comments, required this.user});
  final Comments comments;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s8, horizontal: AppSizes.s12),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: context.width * 0.15,
            height: context.width * 0.15,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xffE6007E), Color(0xff224982)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: 63,
                height: 63,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xffE6007E), Color(0xff224982)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(63),
                    child: CachedNetworkImage(
                        imageUrl: user.avatar!,
                        fit: BoxFit.cover,
                        height: 63,
                        width: 63,
                        placeholder: (context, url) => const ShimmerAnimatedLoading(
                          width: 63.0,
                          height: 63,
                          circularRaduis: 63,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                        )),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppThemeService.colorPalette.secondaryTextColor.color,
                            fontSize: 10,
                          ),
                        ),
                       const SizedBox.shrink(),
                      ],
                    ),
                    Text(
                      DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.parse("${comments.createdAt}")),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppThemeService.colorPalette.quaternaryTextColor.color,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
                SizedBox(height:comments.content != null ? 5 : 0,),
                comments.content != null ? Text(
                  comments.content!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppThemeService.colorPalette.tertiaryTextColor.color,
                    fontSize: AppSizes.s8,
                  ),
                ) : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
