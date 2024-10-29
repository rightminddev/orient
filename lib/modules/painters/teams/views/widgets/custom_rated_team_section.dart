import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';

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
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: teamImageRaduis,
              child: Image.asset(
                teamImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 45,
               left: 40,
              child: Image.asset(
                ratedImage,
                width: ratedImageWidth,
                height: ratedImageHeight,
              ),
            ),
          ],
        ),
        gapH10,
        Text(
          points.toUpperCase(),
          style: const TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w600,
            color: Color(AppColors.textC5),
          ),
        ),
        gapH4,
        Text(
          teamName.toUpperCase(),
          style: const TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w500,
            color: Color(AppColors.textC5),
          ),
        ),
      ],
    );
  }
}
