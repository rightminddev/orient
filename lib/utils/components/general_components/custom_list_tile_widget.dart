import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/media_query_values.dart';

import '../../cached_network_image_widget.dart';

class CustomListTileWidget extends StatelessWidget {
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String image;
  final double? imageRadius;
  final bool isImageUrl;
  final String title;
  final String? subtitle;
  final Color? titleFontColor;
  final FontWeight? titleFontWeight;
  final double? titleFontSize;
  final Color? subtitleFontColor;
  final FontWeight? subtitleFontWeight;
  final double? subtitleFontSize;
  final bool isButtonOneVisible;
  final bool isButtonTwoVisible;

  final String? buttonOneTitle;
  final String? buttonTwoTitle;
  final Color? buttonOneColor;
  final Color? buttonTwoColor;
  final VoidCallback? buttonOneOnPressed;
  final VoidCallback? buttonTwoOnPressed;
  const CustomListTileWidget({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    required this.image,
    this.imageRadius,
    this.isImageUrl = true,
    required this.title,
    this.subtitle,
    this.titleFontColor,
    this.titleFontWeight,
    this.titleFontSize,
    this.subtitleFontColor,
    this.subtitleFontWeight,
    this.subtitleFontSize,
    this.isButtonOneVisible = false,
    this.isButtonTwoVisible = false,
    this.buttonOneTitle,
    this.buttonTwoTitle,
    this.buttonOneColor,
    this.buttonTwoColor,
    this.buttonOneOnPressed,
    this.buttonTwoOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: padding ??
          const EdgeInsets.symmetric(
              vertical: AppSizes.s18, horizontal: AppSizes.s16),
      decoration: ShapeDecoration(
        color: backgroundColor ??
            AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.s16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                isImageUrl == true
                    ? CachedNetWokImageWidget(
                        url: image,
                        width: imageRadius != null
                            ? imageRadius! * 2
                            : context.width * 0.15,
                        height: imageRadius != null
                            ? imageRadius! * 2
                            : context.width * 0.15,
                        radius: imageRadius ?? context.width * 0.08,
                      )
                    : Image.asset(
                        image,
                        width: imageRadius != null
                            ? imageRadius! * 2
                            : context.width * 0.15,
                        height: imageRadius != null
                            ? imageRadius! * 2
                            : context.width * 0.15,
                      ),
                const SizedBox(width: AppSizes.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: titleFontWeight,
                                  color: titleFontColor ??
                                      AppThemeService
                                          .colorPalette.tertiaryTextColor.color,
                                  fontSize: titleFontSize,
                                ),
                      ),
                      subtitle != null
                          ? Text(
                              subtitle!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: subtitleFontWeight,
                                    color: subtitleFontColor ??
                                        AppThemeService.colorPalette
                                            .quaternaryTextColor.color,
                                    fontSize: subtitleFontSize,
                                  ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isButtonOneVisible == true
                  ? ButtonWidget(
                      onPressed: buttonOneOnPressed,
                      borderRadius: 8,
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSizes.s16),
                      title: buttonOneTitle ?? '',
                      backgroundColor:
                          buttonOneColor, //const Color(AppColors.red1),
                    )
                  : const SizedBox.shrink(),
              isButtonTwoVisible == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: AppSizes.s8),
                      child: ButtonWidget(
                        borderRadius: 8,
                        onPressed: buttonTwoOnPressed,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s16),
                        title: buttonTwoTitle ?? '', //'REMOVE',
                        backgroundColor:
                            buttonTwoColor, //const Color(AppColors.red1),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
