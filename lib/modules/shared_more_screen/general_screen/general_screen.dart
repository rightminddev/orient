import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/shared_more_screen/general_screen/logic/general_controller.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:orient/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class GeneralDataScreen extends StatelessWidget {
  final String slug;
  GeneralDataScreen({super.key, required this.slug});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => GeneralController()..getGeneralData(context, slug: slug),
    child: Consumer<GeneralController>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: (!value.isLoading)?Container(
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
                                value.dataTitle.toUpperCase(),
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
                       if(slug == "privacy-policy" && value.dataimage != null) ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.225,
                            fit: BoxFit.fill,
                            imageUrl: value.dataimage,
                            placeholder: (context, url) =>
                            const ShimmerAnimatedLoading(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: AppSizes.s32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if(slug == "privacy-policy" && value.dataimage != null)  gapH24,
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(25),
                        //   child: CachedNetworkImage(
                        //     width: MediaQuery.of(context).size.width,
                        //     height: MediaQuery.of(context).size.height * 0.225,
                        //     fit: BoxFit.fill,
                        //     imageUrl: image,
                        //     placeholder: (context, url) =>
                        //     const ShimmerAnimatedLoading(),
                        //     errorWidget: (context, url, error) => const Icon(
                        //       Icons.image_not_supported_outlined,
                        //       size: AppSizes.s32,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        // gapH14,
                        // Text(
                        //   "title",
                        //   style: const TextStyle(
                        //       fontSize: AppSizes.s16,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(AppColors.oC1Color)),
                        // ),
                        // gapH14,
                        Html(
                            data: value.dataContent,
                            style: TextsStyles.htmlStyle),
                      ],
                    ),
                  )): Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    ),
    );
  }
}
