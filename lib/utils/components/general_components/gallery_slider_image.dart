import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/home/model/color_trend_model.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
class ImageGallerySlider extends StatefulWidget {
  List? listImageUrl = [];
  ImageGallerySlider({super.key, required this.listImageUrl});
  @override
  _ImageGallerySliderState createState() => _ImageGallerySliderState();
}

class _ImageGallerySliderState extends State<ImageGallerySlider> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }
  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.position.pixels <
          _scrollController.position.maxScrollExtent) {
        _scrollController.animateTo(
          _scrollController.position.pixels + 200,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: ListView.separated(
        shrinkWrap: true,
        reverse: false,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.listImageUrl!.length,
        itemBuilder: (context, index) {
          double imageWidth = index % 2 == 0 ? 280.0 : 92.0;
          return Container(
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl:widget.listImageUrl![index]['file'],
                  width: imageWidth,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const ShimmerAnimatedLoading(
                    circularRaduis:
                    AppSizes.s50,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined,)),
            ),
          );
        },
        separatorBuilder: (context, index) =>const SizedBox(width: 10),
      ),
    );
  }
}
