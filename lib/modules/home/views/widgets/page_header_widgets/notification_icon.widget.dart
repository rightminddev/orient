import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';

class NotificationIcon extends StatelessWidget {
  final bool hasNewNotifications;
  final VoidCallback onTap;
  final int numOfUnreadNotifications;

  const NotificationIcon(
      {super.key,
      required this.onTap,
      required this.hasNewNotifications,
      required this.numOfUnreadNotifications});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Stack(
        children: [
          Container(
            width: AppSizes.s50,
            height: AppSizes.s40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2)),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: AppSizes.s28,
            ),
          ),
          if (hasNewNotifications)
            Positioned(
              right: 0,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.s4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: AutoSizeText(
                    numOfUnreadNotifications.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
