import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class FingerprintLoadingScreenWidget extends StatelessWidget {
  const FingerprintLoadingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        7,
        (index) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.s8),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ShimmerAnimatedLoading(
                    circularRaduis: AppSizes.s8,
                    width: AppSizes.s40,
                    height: AppSizes.s50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerAnimatedLoading(
                          width: AppSizes.s90,
                        ),
                        gapH6,
                        ShimmerAnimatedLoading(
                          width: AppSizes.s120,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            gapH12
          ],
        ),
      ),
    );
  }
}
