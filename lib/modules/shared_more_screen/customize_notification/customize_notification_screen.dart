import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:orient/modules/authentication/views/widgets/custom_switch_button.dart';
class CustomizeNotificationScreen extends StatelessWidget {
 bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             Text(AppStrings.customizeNotifications.toUpperCase(), style: const TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.w600,
               color: Color(0xff0D3B6F)
             ),),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchRow(
                    isLoginPageStyle: true,
                    value: isActive,
                    onChanged: (newValue) =>
                    isActive = !isActive,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Buttons
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff0D3B6F),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/ecommerce/svg/apply_filter.svg"),
                        const SizedBox(width: 15,),
                        Text(
                          AppStrings.saveChanges.tr().toUpperCase(),
                          style:const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFFFFFF)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
}
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
          Text( AppStrings.deactivate.tr().toUpperCase(), style: const TextStyle(fontSize: 14 , color: Color(0xff224982), fontWeight: FontWeight.w500)),
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
          Text( AppStrings.activation.tr().toUpperCase(), style: const TextStyle(fontSize: 14 , color: Color(0xff224982), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
