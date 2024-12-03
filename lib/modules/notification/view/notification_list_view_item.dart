import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class PainterNotificationListViewItem extends StatelessWidget {
  final List notifications;
  final int index;
  const PainterNotificationListViewItem({super.key, required this.notifications, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         context.pushNamed(AppRoutes.notificationDetails.name,
            pathParameters: {'lang': context.locale.languageCode,
              "date" : "${notifications[index]['created_at']}",
              "image" :(notifications[index]['main_thumbnail'].isNotEmpty)? "${notifications[index]['main_thumbnail'][0]['file']}": "https://th.bing.com/th/id/R.234a9f3cd371aaa8c7ff9f07354530a5?rik=nDLlZSdsVzVsyA&pid=ImgRaw&r=0",
              "title" : "${notifications[index]['title']}",
              "contant" : "${notifications[index]['content']}"
            });
      },
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSizes.s15, vertical: AppSizes.s12),
        decoration: BoxDecoration(
          color: const Color(AppColors.textC5),
          borderRadius: BorderRadius.circular(AppSizes.s15),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                spreadRadius: 0,
                offset: Offset(0, 1),
                blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            Container(
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
                      imageUrl: (notifications[index]['main_thumbnail'].isNotEmpty)?
                      notifications[index]['main_thumbnail'][0]['file'] : "",
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
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
            gapW8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${notifications[index]['created_at']}".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff606060)),
                  ),
                  gapH4,
                  Html(
                      shrinkWrap: true,
                      data: "${notifications[index]['title']}",
                      style: {
                        "p": Style(
                            fontSize: FontSize(12),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0D3B6F)),
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
