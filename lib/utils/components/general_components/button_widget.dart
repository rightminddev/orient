import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';

import '../../../constants/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderSide borderSide;
  final EdgeInsets? padding;
  final bool? isLoading;
  final String title;
  final String? svgIcon;
  final Color? svgIconColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? buttonHeight;
  final double? buttonWidth;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.buttonHeight,
    this.borderRadius = 50,
    this.borderSide = BorderSide.none,
    this.padding,
    required this.title,
    this.isLoading = true,
    this.svgIcon,
    this.svgIconColor,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    this.buttonWidth,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading == false ? onPressed : null,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          padding ??
              EdgeInsets.symmetric(
                  horizontal: AppSizes.s18, vertical: AppSizes.s12),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor ?? Color(AppColors.oc1),
        ),
      ),
      // child: Container(
      //padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      // decoration: ShapeDecoration(
      //   color: backgroundColor ?? AppColors.whiteBackground,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(borderRadius ?? 6),
      //     side: borderSide,
      //   ),
      // ),
      child: (padding == EdgeInsets.zero)
          ? SizedBox(
              height: buttonHeight ?? 50,
              width: buttonWidth ?? 225,
              child: isLoading == false
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgIcon != null
                            ? Padding(
                                padding: EdgeInsets.only(right: AppSizes.s12),
                                child: SvgPicture.asset(
                                  svgIcon!,
                                  colorFilter: ColorFilter.mode(
                                      svgIconColor ??
                                          AppThemeService
                                              .colorPalette.fabIconColor.color,
                                      BlendMode.srcIn),
                                  fit: BoxFit.scaleDown,
                                ),
                              )
                            : SizedBox.shrink(),
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: fontWeight ?? FontWeight.w500,
                                    height: 0.08,
                                    color: fontColor ??
                                        AppThemeService.colorPalette
                                            .quinaryTextColor.color,
                                    fontSize: fontSize,
                                  ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          : isLoading == false
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    svgIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(right: AppSizes.s12),
                            child: SvgPicture.asset(
                              svgIcon!,
                              colorFilter: ColorFilter.mode(
                                  svgIconColor ??
                                      AppThemeService
                                          .colorPalette.fabIconColor.color,
                                  BlendMode.srcIn),
                              fit: BoxFit.scaleDown,
                            ),
                          )
                        : SizedBox.shrink(),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: fontWeight ?? FontWeight.w500,
                            height: 0.08,
                            color: fontColor ??
                                AppThemeService
                                    .colorPalette.quinaryTextColor.color,
                            fontSize: fontSize,
                          ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
      // ),
    );
  }
}
