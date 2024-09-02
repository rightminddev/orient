import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../general_services/app_theme.service.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key,
      required this.iconPath,
      this.width = AppSizes.s26,
      this.height = AppSizes.s26,
      required this.onPressed,
      required this.tagSuffix});

  final String iconPath;
  final Function() onPressed;
  final String tagSuffix;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: ValueKey('$iconPath-$tagSuffix'),
      onPressed: onPressed,
      child: Center(
        child: Image.asset(
          iconPath,
          color: AppThemeService.colorPalette.fabIconColor.color,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
