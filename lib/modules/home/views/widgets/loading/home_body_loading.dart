import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../general_services/layout.service.dart';
import '../../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s12, vertical: AppSizes.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerAnimatedLoading(
                width: LayoutService.getWidth(context) / 3,
                height: AppSizes.s28,
              ),
              ShimmerAnimatedLoading(
                width: LayoutService.getWidth(context) / 4,
                height: AppSizes.s28,
              ),
            ],
          ),
          gapH16,
          ...List.generate(
              5,
              (index) => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.s14, horizontal: AppSizes.s16),
                    margin: const EdgeInsets.only(bottom: AppSizes.s16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShimmerAnimatedLoading(
                              height: AppSizes.s18,
                              width: LayoutService.getWidth(context) / 2,
                            ),
                            gapH4,
                            ShimmerAnimatedLoading(
                              height: AppSizes.s18,
                              width: LayoutService.getWidth(context) / 2,
                            ),
                          ],
                        ),
                        const Spacer(),
                        const ShimmerAnimatedLoading(
                          width: AppSizes.s40,
                          height: AppSizes.s40,
                          circularRaduis: AppSizes.s40,
                        )
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
