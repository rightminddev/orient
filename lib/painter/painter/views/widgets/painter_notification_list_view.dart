import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/painter/views/widgets/painter_notification_list_view_item.dart';

class PainterNotificationListView extends StatelessWidget {
  const PainterNotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: AppSizes.s18,),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const PainterNotificationListViewItem();
      },
    );
  }
}
