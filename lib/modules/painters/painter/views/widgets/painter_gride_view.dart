import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/painter/models/gride_view_item_model.dart';
import 'package:orient/modules/painters/painter/views/widgets/painter_gride_view_item.dart';

class PainterGrideView extends StatelessWidget {
  PainterGrideView({super.key});

  List<GrideViewItemModel> grideItems = [
    GrideViewItemModel(
        image: AppImages.group,
        title: "My Groups",
        backgroundColor: const Color(AppColors.oC1Color)),
    GrideViewItemModel(
        image: AppImages.teamList,
        title: "Team List",
        backgroundColor: const Color(AppColors.oC2Color)),
    GrideViewItemModel(
        image: AppImages.myPoints,
        title: "My Points",
        backgroundColor: const Color(AppColors.yellowColor)),
    GrideViewItemModel(
        image: AppImages.competition,
        title: "competition",
        backgroundColor: const Color(AppColors.grey1Color)),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsDirectional.only(
          start: AppSizes.s16, end: AppSizes.s16, top: AppSizes.s90),
      sliver: SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 54,
          crossAxisSpacing: 12,
          childAspectRatio: 13 / 9,
          children: [
            ...grideItems.map((item) {
              return PainterGridViewItem(
                itemModel: item,
              );
            })
          ]),
    );
  }
}
