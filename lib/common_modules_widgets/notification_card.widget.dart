import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/app_images.dart';
import '../constants/app_sizes.dart';
import '../general_services/date.service.dart';
import '../models/notification.model.dart';
import '../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel? notification;

  const NotificationCard({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    String getPlaceholderImageDependsOnNotificationPType() {
      switch (notification?.ptype?.key?.toLowerCase()) {
        case 'event':
          return AppImages.notificationEvent;
        case 'birthday':
          return AppImages.notificationBirthDay;
        case 'offers':
          return AppImages.notificationOffers;
        case 'rules':
          return AppImages.notificationRules;
        default:
          return AppImages.notificationGeneral;
      }
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      height: AppSizes.s75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.s15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSizes.s8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppSizes.s15),
                    bottomRight: Radius.circular(AppSizes.s15))),
            height: AppSizes.s75,
            width: AppSizes.s75,
            clipBehavior: Clip.antiAlias,
            child: notification?.mainThumbnail?.first.thumbnail != null
                ? CachedNetworkImage(
                    imageUrl: notification!.mainThumbnail!.first.thumbnail!,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const ShimmerAnimatedLoading(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_outlined,
                      size: AppSizes.s32,
                      color: Colors.white,
                    ),
                  )
                : Image.asset(
                    fit: BoxFit.fill,
                    getPlaceholderImageDependsOnNotificationPType()),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: AppSizes.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: AutoSizeText(
                      DateService.formatDate(notification?.createdAt) ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                      maxLines: 1,
                    ),
                  ),
                  gapH4,
                  AutoSizeText(
                    notification?.title ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
