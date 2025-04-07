//
// import 'package:flutter/material.dart';
// import 'package:otient_test/constants/app_images.dart';
// import 'package:otient_test/constants/app_sizes.dart';
// import 'package:otient_test/post/post_details_screen.dart';
// import 'package:otient_test/post/post_model.dart';
// import 'package:otient_test/post/show_image_widget.dart';
// import 'package:otient_test/post/show_video_widget.dart';
//
// class PostWidget extends StatelessWidget {
//   // final List<PostModel> posts = [
//   //   PostModel(
//   //     text: 'This is a text post with media items',
//   //     mediaItems: [
//   //       // MediaItem(url: 'https://4.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/4684313123.jpg', type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
//   //           type: MediaType.video),
//   //       // MediaItem(url: 'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', type: MediaType.video),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //       MediaItem(
//   //           url:
//   //               'https://3.img-dpreview.com/files/p/TS250x250~sample_galleries/3800753625/8719688791.jpg',
//   //           type: MediaType.image),
//   //     ],
//   //     postDate: DateTime.now(),
//   //   ),
//   // ];
//   // late int mediaCount;
//   // late List<MediaItem> visibleMediaItems;
//
//   PostWidget({super.key}) {
//     // mediaCount = posts[0].mediaItems.length;
//     // visibleMediaItems = posts[0].mediaItems.take(4).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppSizes.s20, vertical: AppSizes.s15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(AppSizes.s15),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: AppSizes.s40,
//                 width: AppSizes.s40,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: ClipOval(
//                     child: Image.asset(
//                   AppImages.splashScreenBackground,
//                   fit: BoxFit.fill,
//                 )),
//               ),
//               gapW12,
//               Text(
//                 "Ahmed Muhammed",
//                 style: TextStyle(fontSize: 15, color: Colors.black),
//               ),
//             ],
//           ),
//           gapH16,
//           Text(
//             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
//             style: TextStyle(
//               fontSize: 11,
//               color: Color(0xff464646),
//             ),
//           ),
//           gapH12,
//           _buildMediaGrid(visibleMediaItems, mediaCount),
//           gapH16,
//           Row(
//             children: [
//               Image.asset(AppImages.messagesImage),
//               gapW12,
//               Text(
//                 "30  -  Show comments",
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: Color(0xff000000),
//                     fontWeight: FontWeight.w600),
//               ),
//               Spacer(),
//               Text(
//                 "35 min ago",
//                 style: TextStyle(
//                     fontSize: 9,
//                     color: Color(0xff9E9898),
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMediaGrid(
//       List<MediaItem> visibleMediaItems, int totalMediaCount) {
//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 3,
//         mainAxisSpacing: 3,
//         mainAxisExtent: 100,
//       ),
//       itemCount: visibleMediaItems.length,
//       itemBuilder: (context, index) {
//         MediaItem mediaItem = visibleMediaItems[index];
//
//         if (index == 3 && totalMediaCount > 4) {
//           int extraCount = totalMediaCount - 4;
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return PostDetailsScreen(
//                  // items: visibleMediaItems,
//                 );
//               }));
//             },
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 _buildMediaPreview(index, mediaItem), // Show the 4th media item
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black45,
//                       borderRadius:
//                           BorderRadius.only(bottomRight: Radius.circular(4))),
//                   child: Center(
//                     child: Text(
//                       '+$extraCount',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return PostDetailsScreen(
//                   //  items: visibleMediaItems
//                 );
//               }));
//             },
//             child: _buildMediaPreview(index, mediaItem));
//       },
//     );
//   }
//
//   Widget _buildMediaPreview(int index, MediaItem mediaItem) {
//     if (mediaItem.type == MediaType.image) {
//       return ShowImageWidget(index: index, mediaItem: mediaItem);
//     } else if (mediaItem.type == MediaType.video) {
//       return ShowVideoWidget(showControls: false,);
//     }
//     return Container();
//   }
// }
