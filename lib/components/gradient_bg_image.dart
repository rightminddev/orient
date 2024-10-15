import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';

import '../constants/app_sizes.dart';

class GradientBgImage extends StatelessWidget {
  final Widget child;
  const GradientBgImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s24, vertical: AppSizes.s24),
      decoration: BoxDecoration(
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
      child: child,
    );
  }
}
