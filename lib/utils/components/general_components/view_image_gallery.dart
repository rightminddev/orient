import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
Widget defaultViewImageGallery({ List? listImagesUrl , bool url = false})=> listImagesUrl!.isEmpty
    ? Center(child: CircularProgressIndicator())
    : MasonryGridView.builder(
      shrinkWrap: true,
      reverse: false,
      padding: EdgeInsets.zero,
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
                    url: url,
                  ),
                ),
              );
            },
            child:ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  imageUrl:url ==  false ? listImagesUrl![index]['file'] :listImagesUrl![index]['images'][0]['file'],
                  fit: BoxFit.fill,
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
    );
class FullScreenImageViewer extends StatelessWidget {
  final List? imageUrls;
  final bool? url;
  final int initialIndex;

  FullScreenImageViewer({required this.imageUrls, required this.initialIndex,required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child:const Icon(Icons.arrow_back, color: Color(0xffFFFFFF),)),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls!.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage((url == false)?imageUrls![index]['file'] :imageUrls![index]['images'][0]['file']),
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