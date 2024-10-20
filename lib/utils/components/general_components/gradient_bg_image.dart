import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';

class GradientBgImage extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const GradientBgImage({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.amber,
        gradient: LinearGradient(
          begin: const Alignment(-1, 0),
          // radius: 0.54,
          colors: [
            // const Color(AppColors.oc2).withOpacity(0.02),
            // const Color(AppColors.oc1).withOpacity(0.02)
            Color(0xFFFF007A).withOpacity(0.02),
            Color(0xFF00A1FF).withOpacity(0.02)
          ],
        ),
      ),
      child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                  horizontal: AppSizes.s24, vertical: AppSizes.s24),
          child: child),
    );
  }
}
