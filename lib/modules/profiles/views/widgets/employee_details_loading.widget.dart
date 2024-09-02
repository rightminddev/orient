import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class EmployeeDetailsLoadingWidget extends StatelessWidget {
  const EmployeeDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
      child: Column(
        children: [
          gapH12,
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.s30),
              ),
              clipBehavior: Clip.antiAlias,
              height: AppSizes.s64,
              child: const ShimmerAnimatedLoading()),
          gapH12,
          ...List.generate(
              5,
              (index) => Container(
                  height: AppSizes.s40,
                  margin: const EdgeInsets.only(bottom: AppSizes.s12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      border: Border.all(color: Colors.grey.withOpacity(0.1))),
                  child: const ShimmerAnimatedLoading()))
        ],
      ),
    );
  }
}
