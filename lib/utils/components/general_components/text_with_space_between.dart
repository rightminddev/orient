import 'package:flutter/material.dart';
import 'package:orient/general_services/app_theme.service.dart';

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
        Text(
          textOnLeft,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: textOnLeftFontColor ??
                    AppThemeService.colorPalette.secondaryTextColor.color,
                fontSize: textOnLeftFontSize,
                fontWeight: textOnLeftFontWeight,
              ),
        ),
        Text(
          textOnRight,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textOnRightFontColor ??
                    AppThemeService.colorPalette.quaternaryTextColor.color,
                fontSize: textOnRightFontSize,
                fontWeight: textOnRightFontWeight,
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
        Row(
          children: [
            Text(
              'TRACKING NUMBER:',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color:
                        AppThemeService.colorPalette.secondaryTextColor.color,
                  ),
            ),
            Text(
              textOnLeft,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppThemeService.colorPalette.tertiaryTextColor.color,
                  ),
            ),
          ],
        ),
        Text(
          textOnRight,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0xFF2AA952),
              ),
        ),
      ],
    );
  }
}
