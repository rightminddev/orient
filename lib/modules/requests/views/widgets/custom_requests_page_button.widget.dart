import 'package:flutter/material.dart';

import '../../../../constants/app_sizes.dart';

class CustomRequestsPageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  const CustomRequestsPageButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.s14,
            horizontal: AppSizes.s12,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: AppSizes.s22,
            ),
            gapW12,
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
