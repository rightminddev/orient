import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';

class CustomButtonBottomSheet extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback function;
  final int backGroundColor;

  const CustomButtonBottomSheet(
      {super.key,
      required this.image,
      required this.title,
      required this.backGroundColor,
      required this.function});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: function,
        icon: SvgPicture.asset(
          image,
          width: AppSizes.s24,
          height: AppSizes.s24,
        ),
        label: Text(
          title.toUpperCase(),
          style: const TextStyle(
              fontSize: AppSizes.s12,
              fontWeight: FontWeight.w500,
              color: Color(AppColors.textC5)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(backGroundColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s50),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
