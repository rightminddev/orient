import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/painter/models/gride_view_item_model.dart';

class MerchantGrideViewItem extends StatelessWidget {
  final GrideViewItemModel itemModel;

  const MerchantGrideViewItem({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(AppColors.textC5),
              borderRadius: BorderRadius.circular(AppSizes.s15)),
          padding: const EdgeInsetsDirectional.only(
            bottom: AppSizes.s30,
            start: AppSizes.s12,
            end: AppSizes.s12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                itemModel.title.toUpperCase(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff224982)),
              ),
              gapH4,
              Text(
                "Customize notifications".toUpperCase(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff231F20)),
              ),
            ],
          ),
        ),
        Positioned(
          top: -32,
          child: Container(
            width: AppSizes.s64,
            height: AppSizes.s64,
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.all(AppSizes.s12),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                      blurRadius: 5)
                ],
                color: itemModel.backgroundColor,
                borderRadius: BorderRadius.circular(AppSizes.s15)),
            child: SvgPicture.asset(
              itemModel.image,
              width: AppSizes.s36,
              height: AppSizes.s36,
            ),
          ),
        ),
      ],
    );
  }
}
