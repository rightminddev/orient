import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../general_services/layout.service.dart';
import '../../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class HomeAppbarLoading extends StatelessWidget {
  const HomeAppbarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.s28),
            bottomRight: Radius.circular(AppSizes.s28)),
      ),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: AppSizes.s16,
          right: AppSizes.s16),
      child: Column(
        children: [
          gapH18,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ShimmerAnimatedLoading(
                width: AppSizes.s40,
                height: AppSizes.s40,
                circularRaduis: AppSizes.s40,
              ),
              gapW12,
              ShimmerAnimatedLoading(
                height: AppSizes.s32,
                width: LayoutService.getWidth(context) / 2,
              ),
              const Spacer(),
              const ShimmerAnimatedLoading(
                width: AppSizes.s40,
                height: AppSizes.s40,
                circularRaduis: AppSizes.s40,
              )
            ],
          ),
          gapH32,
          Row(
              children: List.generate(
                  3,
                  (index) => Padding(
                      padding: const EdgeInsets.only(right: AppSizes.s12),
                      child: ShimmerAnimatedLoading(
                        width: (LayoutService.getWidth(context) -
                                (AppSizes.s32 + ((AppSizes.s12) * 3))) /
                            3,
                        height: AppSizes.s120,
                      ))))
        ],
      ),
    );
  }
}
