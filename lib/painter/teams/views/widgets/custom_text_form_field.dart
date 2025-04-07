import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isSuffix;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
       this.maxLines=1,
       this.isSuffix=false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(AppColors.bgC3),
        hintText: hintText.toUpperCase(),
        
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w400,
            color: Color(AppColors.grey1Color)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            borderSide:
                const BorderSide(color: Color(AppColors.inputBorderColor))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            borderSide:
                const BorderSide(color: Color(AppColors.inputBorderColor))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            borderSide: const BorderSide(color: Color(AppColors.oC2Color))),
        suffixIcon:isSuffix? Padding(
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(
            AppImages.uploadImage,
            width: AppSizes.s15,
            height: AppSizes.s15,
          ),
        ):const SizedBox(),
      ),
    );
  }
}
