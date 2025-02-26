import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/blog/controller/blog_controller.dart';
import 'package:orient/modules/notification/view/notification_details_loading.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:orient/utils/styles.dart';
import 'package:provider/provider.dart';

class BlogListDetailsScreen extends StatelessWidget {
   String? title;
   BlogListDetailsScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => BlogProviderModel()..getOneBlog(context, id: title.toString()),
    child: Consumer<BlogProviderModel>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          body: GradientBgImage(
            padding: EdgeInsets.zero,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s15),
                child: (value.getOneBlogModel != null)? SingleChildScrollView(
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
                              AppStrings.blogDetails.tr().toUpperCase(),
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
                      if(value.getOneBlogModel!.item!.mainThumbnail != null && value.getOneBlogModel!.item!.mainThumbnail!.isNotEmpty ) ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.225,
                          fit: BoxFit.cover,
                          imageUrl: value.getOneBlogModel!.item!.mainThumbnail![0].file ?? "",
                          placeholder: (context, url) =>
                          const ShimmerAnimatedLoading(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_not_supported_outlined,
                            size: AppSizes.s32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if(value.getOneBlogModel!.item!.mainThumbnail != null && value.getOneBlogModel!.item!.mainThumbnail!.isNotEmpty)   gapH24,
                      Row(
                        children: [
                          Text(
                            (value.getOneBlogModel!.item!.createdAt != null )?value.getOneBlogModel!.item!.createdAt! : "",
                            style: const TextStyle(
                                fontSize: AppSizes.s10,
                                fontWeight: FontWeight.w400,
                                color: Color(AppColors.oC1Color)),
                          ),
                          const SizedBox(width: 20,),
                          if(value.getOneBlogModel!.item!.category!.title != null)Row(
                            children: [
                              Icon(Icons.category, color: Colors.black,),
                              const SizedBox(width: 5,),
                              Text(
                                value.getOneBlogModel!.item!.category!.title!.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: AppSizes.s10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(AppColors.oC1Color)),
                              ),
                            ],
                          )
                        ],
                      ),
                      gapH14,
                      Text(
                        value.getOneBlogModel!.item!.title ?? "",
                        style: const TextStyle(
                            fontSize: AppSizes.s16,
                            fontWeight: FontWeight.bold,
                            color: Color(AppColors.oC1Color)),
                      ),
                      gapH14,
                      Html(
                          data:   value.getOneBlogModel!.item!.content ?? "",
                          style: TextsStyles.htmlStyle),
                    ],
                  ),
                ): NotificationDetailsLoading()),
          ),
        );
      },
    ),
    );
  }
}
