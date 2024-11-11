import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/home_screen/models/gride_view_item_model.dart';
import 'package:orient/routing/app_router.dart';

import 'painter_gride_view_item.dart';


class PainterGrideView extends StatelessWidget {
  PainterGrideView({super.key});

  @override
  Widget build(BuildContext context) {
    List<GrideViewItemModel> grideItems = [
      GrideViewItemModel(
          image: AppImages.group,
          title: AppStrings.myGroups.tr(),
          onTap: (){
            context.pushNamed(AppRoutes.painterViewMyGroupsScreen.name,
                pathParameters: {'lang': context.locale.languageCode,});
          },
          backgroundColor: const  Color(AppColors.oC1Color)),
      GrideViewItemModel(
          image: AppImages.teamList,
          title: AppStrings.teamList.tr(),
          onTap: (){
            context.pushNamed(AppRoutes.painterViewTeamsScreen.name,
                pathParameters: {'lang': context.locale.languageCode,});
          },
          backgroundColor: const Color(AppColors.oC2Color)),
      GrideViewItemModel(
          image: AppImages.myPoints,
          title: AppStrings.myPoints.tr(),
          onTap: (){
            context.pushNamed(AppRoutes.painterPointsViewScreen.name,
                pathParameters: {'lang': context.locale.languageCode,});
          },
          backgroundColor: const Color(AppColors.yellowColor)),
      GrideViewItemModel(
          image: AppImages.competition,
          title: AppStrings.competition.tr(),
          onTap: (){
            context.pushNamed(AppRoutes.painterRatedTeamsScreen.name,
                pathParameters: {'lang': context.locale.languageCode,});
          },
          backgroundColor: const Color(AppColors.grey1Color)),
    ];
    return SliverPadding(
      padding: const EdgeInsetsDirectional.only(
           top: AppSizes.s90),
      sliver: SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 65,
          crossAxisSpacing: 12,
          childAspectRatio: 14 / 9,
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
