import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CachedNetWokImageWidget extends StatelessWidget {
  const CachedNetWokImageWidget({
    super.key,
    this.url,
    this.height,
    this.width,
    this.boxFit,
    this.radius = 16,
    this.cacheKey,
    this.errorWidget,
    //  this.isShadowed = false,
  });
  final String? url;
  final String? cacheKey;
  final double? height;
  final double? width;
  final double radius;
  //final bool? isShadowed;
  final BoxFit? boxFit;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url!,
      width: width,
      height: height,
      cacheKey: cacheKey ?? url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(child: CircularProgressIndicator()),
      fit: boxFit ?? BoxFit.cover,
      // color: AppColors.error500,
      alignment: Alignment.topCenter,
      filterQuality: FilterQuality.high,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.cover,
          ),
          // boxShadow: isShadowed == true
          //     ? [
          //         BoxShadow(
          //           color: AppColors.primary700,
          //           blurRadius: 4,
          //           offset: const Offset(0, 4),
          //           spreadRadius: 0,
          //         ),
          //       ]
          //     : [],
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        //color: AppColors.error400,
        child: const Icon(Icons.error_outline_outlined),
      ),
    );
  }
}
