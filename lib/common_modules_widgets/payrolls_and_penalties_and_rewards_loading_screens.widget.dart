import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class PayrollsAndPenaltiesRewardsLoadingScreensWidget extends StatelessWidget {
  const PayrollsAndPenaltiesRewardsLoadingScreensWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        7,
        (index) => Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.s14, horizontal: AppSizes.s16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.s10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    offset: const Offset(0, 0),
                    blurRadius: 2.5,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerAnimatedLoading(
                    width: AppSizes.s24,
                    height: AppSizes.s24,
                  ),
                  gapW8,
                  Expanded(
                    child: ShimmerAnimatedLoading(
                      height: AppSizes.s24,
                    ),
                  ),
                  gapW12,
                  ShimmerAnimatedLoading(
                    width: AppSizes.s28,
                    height: AppSizes.s28,
                    circularRaduis: AppSizes.s50,
                  ),
                ],
              ),
            ),
            gapH20
          ],
        ),
      ),
    );
  }
}
