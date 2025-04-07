import 'package:flutter/material.dart';
import 'package:orient/general_services/localization.service.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_strings.dart';
import 'custom_switch_button.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
class SwitchRow extends StatelessWidget {
   bool value;
  final ValueChanged<bool> onChanged;
  final String? rightText;
  final String? leftText;
  final bool? isLoginPageStyle;

   SwitchRow({
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
            ?.copyWith(fontSize: AppSizes.s12, fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.displaySmall;
    value = true;
    print("VALUE IS --> $value");
    return Directionality(
      textDirection: LocalizationService.isArabic(context: context)? TextDirection.ltr : TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            rightText ?? AppStrings.byEmail.tr(),
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
            leftText ?? AppStrings.byPhone.tr(),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
