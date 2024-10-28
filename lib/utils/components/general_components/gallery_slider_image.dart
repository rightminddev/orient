import 'dart:async';
import 'package:flutter/material.dart';
class ImageGallerySlider extends StatefulWidget {
  List<String> listImageUrl = [];
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
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.separated(
        shrinkWrap: true,
        reverse: false,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.listImageUrl.length,
        itemBuilder: (context, index) {
          double imageWidth = index % 2 == 0 ? 280.0 : 92.0;
          return SizedBox(
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.listImageUrl[index],
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>const SizedBox(width: 10),
      ),
    );
  }
}