import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_sizes.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: AppSizes.s20,
            width: AppSizes.s20,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : const Color(0xFF676D75),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: AppSizes.s6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.s10,
              letterSpacing: 1,
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : const Color(0xFF676D75),
            ),
          ),
        ],
      ),
    );
  }
}
