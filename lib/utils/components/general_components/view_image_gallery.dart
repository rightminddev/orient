import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
Widget defaultViewImageGallery(
    {required List<String>? listImagesUrl}
    )=> listImagesUrl!.isEmpty
    ? Center(child: CircularProgressIndicator())
    : Padding(
  padding: const EdgeInsets.all(8.0),
  child: MasonryGridView.builder(
    shrinkWrap: true,
    reverse: false,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: (listImagesUrl!.length <= 7) ? 2 : 3,
    ),
    itemCount: listImagesUrl.length,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height:(listImagesUrl!.length <= 7) ? (index % 2 == 0) ? 180 : 80 : (index % 3 == 0) ? 200 : 100,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageViewer(
                  imageUrls: listImagesUrl,
                  initialIndex: index,
                ),
              ),
            );
          },
          child:ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                imageUrl: listImagesUrl[index]!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ShimmerAnimatedLoading(
                  width:  100,
                  height: 100,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported_outlined,
                )),
          ),
        ),
      );
    },
  ),
);
class FullScreenImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  FullScreenImageViewer({required this.imageUrls, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}