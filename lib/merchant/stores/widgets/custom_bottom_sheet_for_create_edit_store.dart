import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../utils/components/general_components/button_widget.dart';

class CustomBottomSheetForCreateEditStore extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  const CustomBottomSheetForCreateEditStore({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 11,
            offset: Offset(0, -4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonWidget(
            isLoading: isLoading,
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s48, vertical: AppSizes.s16),
            title: title,
            svgIcon: AppIcons.checkMarkDashed,
          ),
        ],
      ),
    );
  }
}
