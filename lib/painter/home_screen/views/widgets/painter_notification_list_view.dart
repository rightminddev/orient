import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/painter/views/widgets/painter_notification_list_view_item.dart';

class PainterNotificationListView extends StatelessWidget {
  const PainterNotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: AppSizes.s12),
      itemCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const PainterNotificationListViewItem();
      },
    );
  }
}
