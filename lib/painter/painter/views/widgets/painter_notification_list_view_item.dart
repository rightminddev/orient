import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/list/views/single_list_details_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class PainterNotificationListViewItem extends StatelessWidget {
  const PainterNotificationListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.notificationDetails.name,
            pathParameters: {'lang': context.locale.languageCode,});
      },
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSizes.s15, vertical: AppSizes.s12),
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
                      imageUrl: "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
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
                    "10/04/2022 08:15:36 PM".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff606060)),
                  ),
                  gapH4,
                  Text(
                    "Ramadan Kareem to you all and every year and you"
                        .toUpperCase(),
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D3B6F)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
