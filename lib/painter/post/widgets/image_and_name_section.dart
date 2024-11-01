import 'package:flutter/material.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/post/data/models/post_response.dart';

import '../post_model.dart';

class ImageAndNameSection extends StatelessWidget {
  ImageAndNameSection({super.key, required this.user,});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: AppSizes.s40,
          width: AppSizes.s40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
              child: Image.asset(
                AppImages.splashScreenBackground,
                fit: BoxFit.fill,
              )),
        ),
        gapW12,
        Text(
          user.name ?? '',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }
}
