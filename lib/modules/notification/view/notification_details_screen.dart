import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/models/notification.model.dart';
import 'package:orient/modules/notification/logic/notification_provider.dart';
import 'package:orient/modules/notification/view/notification_details_loading.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:orient/utils/styles.dart';
import 'package:provider/provider.dart';

class SingleListDetailsScreen extends StatelessWidget {
  final String? date;
  final String? image;
  final String title;
  final String contant;
  var id;
  SingleListDetailsScreen({super.key, this.id, required this.date, required this.image, required this.title, required this.contant});

  @override
  Widget build(BuildContext context) {
    print("NOTI IMAGE IS --> $image");
    return ChangeNotifierProvider(create: (context) => NotificationProviderModel()..getNotificationSingle(context, id),
    child: Consumer<NotificationProviderModel>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s15),
                  child: (value.notificationModel != null && value.isGetNotificationLoading == false)? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 90,
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
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
                                AppStrings.notificationsDetails.tr().toUpperCase(),
                                style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                                  onPressed: (){}
                              ),
                            ],
                          ),
                        ),
                        gapH16,
                        if(value.notificationModel!.mainThumbnail!.isNotEmpty)  ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.225,
                            fit: BoxFit.fill,
                            imageUrl: value.notificationModel!.mainThumbnail![0].file!,
                            placeholder: (context, url) =>
                            const ShimmerAnimatedLoading(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: AppSizes.s32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if(value.notificationModel!.mainThumbnail!.isNotEmpty)  gapH24,
                        if(value.notificationModel!.createdAt != null) Text(
                          value.notificationModel!.createdAt!,
                          style: const TextStyle(
                              fontSize: AppSizes.s10,
                              fontWeight: FontWeight.w400,
                              color: Color(AppColors.oC1Color)),
                        ),
                        gapH14,
                        Text(
                          value.notificationModel!.title!,
                          style: const TextStyle(
                              fontSize: AppSizes.s16,
                              fontWeight: FontWeight.bold,
                              color: Color(AppColors.oC1Color)),
                        ),
                        gapH14,
                        Html(
                            data: value.notificationModel!.content!,
                            style: TextsStyles.htmlStyle),
                      ],
                    ),
                  ) : NotificationDetailsLoading()
              ),
            ),
          );
        },
    ),
    );
  }
}
