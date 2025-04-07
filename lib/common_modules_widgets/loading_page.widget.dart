import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../general_services/layout.service.dart';
import '../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class LoadingPageWidget extends StatelessWidget {
  final double? height;
  final bool? reverse;
  const LoadingPageWidget({super.key, this.height, this.reverse});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            5,
            (index) => Container(
                  height: height,
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
                    children: reverse == true
                        ? [
                            const ShimmerAnimatedLoading(
                              width: AppSizes.s40,
                              height: AppSizes.s40,
                              circularRaduis: AppSizes.s40,
                            ),
                            gapW8,
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
                          ]
                        : [
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
                )));
  }
}
