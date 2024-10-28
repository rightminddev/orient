import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';
class ColorTrendAppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Container(
          height: 330,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRRect(
                borderRadius:const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)
                ),
                child: CachedNetworkImage(
                    imageUrl: homeProvider.colorTrendModel!.page!.coverForWeb![0].file!,
                    height: 360,
                    fit: BoxFit.cover,
                    placeholder: (context,
                        url) =>
                    const ShimmerAnimatedLoading(
                      circularRaduis:
                      AppSizes.s50,
                    ),
                    errorWidget: (context,
                        url, error) =>
                    const Icon(
                      Icons
                          .image_not_supported_outlined,
                    )),
              ),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.transparent,
                height: 90,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xffFFFFFF)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      AppStrings.colorTrend.tr().toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.transparent),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
