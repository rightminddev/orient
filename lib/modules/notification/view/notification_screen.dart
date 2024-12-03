import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/notification/logic/notification_provider.dart';
import 'package:orient/modules/notification/view/notification_list_view_item.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  final bool viewArrow;
  NotificationScreen(this.viewArrow);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  late NotificationProviderModel notificationProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationProvider = Provider.of<NotificationProviderModel>(context, listen: false);
      notificationProvider.getNotification(context, page: 1);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !notificationProvider.isGetNotificationLoading &&
          notificationProvider.hasMoreNotifications) {
        notificationProvider.getNotification(context, page: notificationProvider.currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProviderModel>(
      builder: (context, notificationProviderModel, child) {
        print('UI Rebuilding due to provider update');
        print('UI Rebuilding'); // Add this to verify rebuild
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: GradientBgImage(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 90,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: widget.viewArrow ? const Color(0xff224982) : Colors.transparent),
                            onPressed: () => widget.viewArrow ? Navigator.pop(context) : null,
                          ),
                          Text(
                            AppStrings.notificationsCenter.tr().toUpperCase(),
                            style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.s20),
                    // Notification List inside ListView
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      reverse: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notificationProviderModel.isGetNotificationLoading && notificationProviderModel.notifications.isEmpty
                          ? 12 // Show 5 loading items initially
                          : notificationProviderModel.notifications.length,
                      itemBuilder: (context, index) {
                        if (notificationProviderModel.isGetNotificationLoading && notificationProviderModel.currentPage == 1) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: AppSizes.s12),
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSizes.s15, vertical: AppSizes.s12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(AppSizes.s15),
                              ),
                              height: 100,
                            ),
                          );
                        } else {
                          return PainterNotificationListViewItem(
                            notifications: notificationProviderModel.notifications,
                            index: index,
                          );
                        }
                      },
                    ),
                    if (notificationProviderModel.isGetNotificationLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
