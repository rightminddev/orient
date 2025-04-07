import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../common_modules_widgets/notification_card.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../models/notification.model.dart';

class NotificationsSection extends StatelessWidget {
  final List<NotificationModel> notifications;
  const NotificationsSection({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s12, vertical: AppSizes.s20),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.myNotifications.tr(),
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(AppStrings.viewAll.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          gapH16,
          ...notifications.map(
            (notification) => NotificationCard(
              notification: notification,
            ),
          )
        ],
      ),
    );
  }
}
