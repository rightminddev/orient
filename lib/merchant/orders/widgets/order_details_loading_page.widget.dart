import 'package:flutter/material.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class OrderDetailsLoadingPage extends StatelessWidget {
  final double? height;
  const OrderDetailsLoadingPage({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 18),
        Row(
          children: [
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 3,
            ),
            gapW4,
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 2,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 3,
            ),
            gapW4,
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 2,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 3,
            ),
            gapW4,
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 2,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 3,
            ),
            gapW4,
            ShimmerAnimatedLoading(
              height: AppSizes.s18,
              width: LayoutService.getWidth(context) / 2,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ShimmerAnimatedLoading(
                width: 100.0,
                height: 104.0,
                circularRaduis: 10,
              ),
              gapW8,
              Column(
                children: [
                  ShimmerAnimatedLoading(
                    height: AppSizes.s18,
                    width: LayoutService.getWidth(context) / 2,
                  ),
                  gapH12,
                  ShimmerAnimatedLoading(
                    height: AppSizes.s18,
                    width: LayoutService.getWidth(context) / 2,
                  ),
                  gapH12,
                  ShimmerAnimatedLoading(
                    height: AppSizes.s18,
                    width: LayoutService.getWidth(context) / 2,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 3,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 3,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 3,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: ShimmerAnimatedLoading(
                height: AppSizes.s18,
                width: LayoutService.getWidth(context) / 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
