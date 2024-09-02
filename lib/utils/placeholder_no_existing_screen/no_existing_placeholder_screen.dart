import 'package:flutter/material.dart';

import '../../constants/app_images.dart';
import '../../constants/app_sizes.dart';

class NoExistingPlaceholderScreen extends StatelessWidget {
  final String title;
  final double? height;
  const NoExistingPlaceholderScreen(
      {super.key, required this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo,
              color: Colors.grey,
              width: AppSizes.s100,
              height: AppSizes.s100,
              fit: BoxFit.cover),
          gapH16,
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
