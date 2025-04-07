import 'package:flutter/material.dart';
import '../../../../common_modules_widgets/loading_page.widget.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class RequestsLoadingPage extends StatelessWidget {
  const RequestsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const LoadingPageWidget()
      ],
    );
  }
}
