import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_strings.dart';
import 'custom_switch_button.dart';

class SwitchRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? rightText;
  final String? leftText;
  final bool? isLoginPageStyle;

  const SwitchRow({
    super.key,
    required this.value,
    required this.onChanged,
    this.rightText,
    this.leftText,
    this.isLoginPageStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = isLoginPageStyle == true
        ? Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontSize: AppSizes.s14, fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.displaySmall;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            leftText ?? AppStrings.byEmail.tr(),
            style: textStyle,
          ),
          gapW8,
          CustomSwitchButton(
            width: AppSizes.s50,
            height: AppSizes.s20,
            padding: AppSizes.s3,
            value: value,
            inactiveColor: const Color(0xff2C376C),
            onChanged: onChanged,
          ),
          gapW8,
          Text(
            rightText ?? AppStrings.byPhone.tr(),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
