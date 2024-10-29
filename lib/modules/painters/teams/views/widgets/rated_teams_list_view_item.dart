import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';

class RatedTeamsListViewItem extends StatelessWidget {
  final int index;

  const RatedTeamsListViewItem({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppSizes.s8, horizontal: AppSizes.s24),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s18,
        vertical: AppSizes.s12,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(AppSizes.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${index + 1}",
                style: const TextStyle(
                  fontSize: AppSizes.s14,
                  fontWeight: FontWeight.w500,
                  color: Color(AppColors.black1Color),
                ),
              ),
              gapW12,
              const CircleAvatar(
                radius: AppSizes.s20,
                backgroundImage: AssetImage(
                  AppImages.circleNotification,
                ),
              ),
              gapW10,
              Text(
                "best first paints".toUpperCase(),
                style: const TextStyle(
                  fontSize: AppSizes.s14,
                  fontWeight: FontWeight.w500,
                  color: Color(AppColors.black1Color),
                ),
              ),
            ],
          ),
          Text(
            "12500".toUpperCase(),
            style: const TextStyle(
              fontSize: AppSizes.s14,
              fontWeight: FontWeight.w500,
              color: Color(AppColors.oC2Color),
            ),
          ),
        ],
      ),
    );
  }
}
