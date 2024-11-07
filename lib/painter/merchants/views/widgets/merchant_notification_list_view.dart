import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/merchants/views/widgets/merchant_notification_list_view_item.dart';

class MerchantNotificationListView extends StatelessWidget {
  const MerchantNotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: AppSizes.s12),
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const MerchantNotificationListViewItem();
      },
    );
  }
}
