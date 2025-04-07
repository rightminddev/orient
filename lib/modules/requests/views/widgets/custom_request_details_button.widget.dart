import 'package:flutter/material.dart';

import '../../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../../constants/app_sizes.dart';

class CustomRequestDetailsButton extends StatelessWidget {
  final String title;
  final Future<void> Function() onPressed;
  final double? width;
  const CustomRequestDetailsButton({
    super.key,
    this.width,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        titleSize: AppSizes.s10,
        width: width,
        buttonStyle: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, double.infinity),
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Colors.transparent,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s28),
          ),
        ),
        onPressed: onPressed,
        title: title,
      ),
    );
  }
}
