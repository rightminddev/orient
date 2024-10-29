import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/painter/models/gride_view_item_model.dart';
import 'package:orient/modules/painters/painter/views/widgets/painter_gride_view_item.dart';

class MerchantGrideView extends StatelessWidget {
  const MerchantGrideView({super.key});

  @override
  Widget build(BuildContext context) {
    List<GrideViewItemModel> grideItems = [
      GrideViewItemModel(
          image: AppImages.myStores,
          title: "MY STORES",
          backgroundColor: const Color(AppColors.oC1Color)),
      GrideViewItemModel(
          image: AppImages.addStore,
          title: "ADD STORE",
          backgroundColor: const Color(AppColors.oC2Color)),
    ];
    return SliverPadding(
      padding: const EdgeInsetsDirectional.only(
          start: AppSizes.s16, end: AppSizes.s16, top: AppSizes.s70),
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
