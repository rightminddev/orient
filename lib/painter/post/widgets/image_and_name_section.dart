import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

import '../post_model.dart';

class ImageAndNameSection extends StatelessWidget {
  ImageAndNameSection({super.key, required this.user,});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(user.avatar == null)const Icon(
          Icons.image_not_supported_outlined,
          size: AppSizes.s32,
        ),
        if(!user.avatar!.startsWith("https") && !user.avatar!.startsWith("http"))ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            height: AppSizes.s40,
            width: AppSizes.s40,
            fit: BoxFit.cover,
            imageUrl: "https://backend.orient-paints.com/${user.avatar!}",
            placeholder: (context, url) =>
            const ShimmerAnimatedLoading(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: AppSizes.s32,
              color: Colors.white,
            ),
          ),
        ),
       if(user.avatar!.startsWith("https") || user.avatar!.startsWith("http")) ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            height: AppSizes.s40,
            width: AppSizes.s40,
            fit: BoxFit.cover,
            imageUrl: user.avatar!,
            placeholder: (context, url) =>
            const ShimmerAnimatedLoading(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: AppSizes.s32,
              color: Colors.white,
            ),
          ),
        ),
        gapW12,
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Text(
            user.name.toUpperCase() ?? '',
            style: const TextStyle(fontSize: 15, color: Color(0xff1B1B1B), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
