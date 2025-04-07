import 'package:flutter/material.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/general_services/localization.service.dart';

class TextWithSpaceBetween extends StatelessWidget {
  final String textOnLeft;
  final Color? textOnLeftFontColor;
  final FontWeight? textOnLeftFontWeight;
  final double? textOnLeftFontSize;
  final String textOnRight;
  final Color? textOnRightFontColor;
  final FontWeight? textOnRightFontWeight;
  final double? textOnRightFontSize;
  const TextWithSpaceBetween(
      {super.key,
      required this.textOnLeft,
      required this.textOnRight,
      this.textOnLeftFontColor,
      this.textOnLeftFontWeight,
      this.textOnLeftFontSize,
      this.textOnRightFontColor,
      this.textOnRightFontWeight,
      this.textOnRightFontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            textOnLeft,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: textOnLeftFontColor ??
                      AppThemeService.colorPalette.secondaryTextColor.color,
                  fontSize: textOnLeftFontSize,
                  fontWeight: textOnLeftFontWeight,
                  height: 0,
                  letterSpacing: 0,
                ),
          ),
        ),
        Text(
          textOnRight,
          textAlign: LocalizationService.isArabic(context: context)? TextAlign.left: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textOnRightFontColor ??
                    AppThemeService.colorPalette.quaternaryTextColor.color,
                fontSize: textOnRightFontSize,
                fontWeight: textOnRightFontWeight,
                height: 0,
                letterSpacing: 0,
              ),
        ),
      ],
    );
  }
}

class TrackingOrderTextWidget extends StatelessWidget {
  final String textOnLeft;
  final String textOnRight;
  const TrackingOrderTextWidget(
      {super.key, required this.textOnLeft, required this.textOnRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'TRACKING NUMBER:',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color:
                          AppThemeService.colorPalette.secondaryTextColor.color,
                      height: 0,
                      letterSpacing: 0,
                    ),
              ),
              Expanded(
                child: Text(
                  textOnLeft,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppThemeService
                            .colorPalette.tertiaryTextColor.color,
                        height: 0,
                        letterSpacing: 0,
                      ),
                ),
              ),
            ],
          ),
        ),
        Text(
          textOnRight,
          textAlign:LocalizationService.isArabic(context: context)? TextAlign.left: LocalizationService.isArabic(context: context)? TextAlign.left: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0xFF2AA952),
                height: 0,
                letterSpacing: 0,
              ),
        ),
      ],
    );
  }
}
