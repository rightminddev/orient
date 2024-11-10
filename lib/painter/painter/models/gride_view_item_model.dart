import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient/constants/settings/app_icons.dart';

class GrideViewItemModel {
  final String image;
  final String title;
  final Color backgroundColor;

  GrideViewItemModel({
    required this.image,
    required this.title,
    required this.backgroundColor,
  });
}

List<GrideViewItemModel> merchantGrideItems = [
  GrideViewItemModel(
      image: AppIcons.store,
      title: AppStrings.myStores.tr(),
      backgroundColor: const Color(AppColors.oC1Color)),
  GrideViewItemModel(
      image: AppIcons.continueShoppingCart,
      title: AppStrings.addStore.tr(),
      backgroundColor: const Color(AppColors.oC2Color)),
];
