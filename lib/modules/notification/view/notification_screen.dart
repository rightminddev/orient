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

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final notificationProvider = Provider.of<NotificationProviderModel>(context, listen: false);
    notificationProvider.getNotification(context); // Load initial notifications
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !notificationProvider.isGetNotificationLoading) {
        notificationProvider.getNotification(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProviderModel>(
      builder: (context, notificationProviderModel, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                controller: _scrollController,
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
                            icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            AppStrings.notificationsCenter.tr().toUpperCase(),
                            style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                              onPressed: (){}
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.s20,),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index)=> const SizedBox(height: 18,),
                      shrinkWrap: true,
                      reverse: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:(notificationProviderModel.isGetNotificationLoading && notificationProviderModel.currentPage ==1 )? 5 : notificationProviderModel.notifications.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) =>
                        (notificationProviderModel.isGetNotificationLoading&& notificationProviderModel.currentPage ==1)?
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: AppSizes.s12),
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: AppSizes.s15, vertical: AppSizes.s12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSizes.s15),
                            ),
                            height: 100,  // Adjust height to match your layout
                          ),
                        )
                            :
                        PainterNotificationListViewItem(
                          notifications: notificationProviderModel.notifications,
                          index: index ,)
                      ,
                    ),
                    if(notificationProviderModel.isGetNotificationLoading&& notificationProviderModel.currentPage !=1)const SizedBox(height: 10,),
                    if(notificationProviderModel.isGetNotificationLoading&& notificationProviderModel.currentPage !=1) const Center(child: CircularProgressIndicator(),),
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
