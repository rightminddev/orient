import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class ShowImageWidget extends StatelessWidget {
  final int index;
  final String mediaItem;

  const ShowImageWidget({
    required this.index,
    required this.mediaItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
          borderRadius: index == -1
              ? BorderRadius.circular(15)
              : BorderRadius.only(
                  topLeft: index == 0 ? const Radius.circular(15) : Radius.zero,
                  topRight: index == 1 ? const Radius.circular(15) : Radius.zero,
                  bottomLeft: index == 2 ? const Radius.circular(15) : Radius.zero,
                  bottomRight:
                      index == 3 ? const Radius.circular(15) : Radius.zero,
                ),
          child: CachedNetworkImage(
            imageUrl: mediaItem,
            fit: BoxFit.cover,
            height:  200,
            width: double.infinity,
            placeholder: (context, url) =>
            const ShimmerAnimatedLoading(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: AppSizes.s32,
              color: Colors.white,
            ),
          )

      ),
    );
  }
}
