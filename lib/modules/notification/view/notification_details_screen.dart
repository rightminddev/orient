import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class SingleListDetailsScreen extends StatelessWidget {
  final String date;
  final String image;
  final String title;
  final String contant;
  const SingleListDetailsScreen({super.key, required this.date, required this.image, required this.title, required this.contant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s15),
            child: SingleChildScrollView(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.225,
                      fit: BoxFit.fill,
                      imageUrl: image,
                      placeholder: (context, url) =>
                      const ShimmerAnimatedLoading(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: AppSizes.s32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  gapH24,
                   Text(
                    date,
                    style: const TextStyle(
                        fontSize: AppSizes.s10,
                        fontWeight: FontWeight.w400,
                        color: Color(AppColors.oC1Color)),
                  ),
                  gapH14,
                   Text(
                    title,
                    style: const TextStyle(
                        fontSize: AppSizes.s16,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColors.oC1Color)),
                  ),
                  gapH14,
                  Html(
                      data: contant,
                      style: {
                        "p": Style(
                            fontSize: FontSize(AppSizes.s12),
                            fontWeight: FontWeight.w400,
                            color: const Color(AppColors.black1Color)),
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
