import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class RequestsAppbarLoading extends StatelessWidget {
  const RequestsAppbarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
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
                        )))),
            gapH32,
          ],
        ),
      ],
    );
  }
}
