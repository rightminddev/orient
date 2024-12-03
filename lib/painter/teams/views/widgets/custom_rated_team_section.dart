import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class CustomRatedTeamSection extends StatelessWidget {
  final String teamImage;
  final String ratedImage;
  final String teamName;
  final String points;
  final double teamImageRaduis;
  final double ratedImageWidth;
  final double ratedImageHeight;

  const CustomRatedTeamSection(
      {super.key,
      required this.teamImage,
      required this.ratedImage,
      required this.teamName,
      required this.ratedImageHeight,
      required this.ratedImageWidth,
      required this.teamImageRaduis,
      required this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(74),
              child: CachedNetworkImage(
                imageUrl: "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
                fit: BoxFit.cover,
                height: 74,
                width: 74,
                placeholder: (context, url) => const ShimmerAnimatedLoading(
                  width: 74.0,
                  height: 74,
                  circularRaduis: 74,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
              ),
            ),
            Image.asset(
              ratedImage,
              width: ratedImageWidth,
              height: ratedImageHeight,
            ),
          ],
        ),
        gapH10,
        Text(
          points.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w600,
            color: Color(AppColors.textC5),
          ),
        ),
        gapH4,
        Container(
          alignment: Alignment.center,
          width: 105,
          child: Text(
            teamName.toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppSizes.s12,
              fontWeight: FontWeight.w500,
              color: Color(AppColors.textC5),
            ),
          ),
        ),
      ],
    );
  }
}
