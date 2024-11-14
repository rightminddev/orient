import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart' as intl_phone_field;
import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_strings.dart';
import '../../../../general_services/app_theme.service.dart';
import '../../../../general_services/localization.service.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController countryCodeController;
  final String? initialCountry;
  final void Function()? triggerFunction;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.triggerFunction,
    this.initialCountry = 'EG',
    required this.countryCodeController,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  int maxLength = 9;
  int minLength = 9;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          side: const BorderSide(
            color: Color(0xffE3E5E5),
            width: 1.0,
          ),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Directionality(
        textDirection: LocalizationService.isArabic(context: context)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: intl_phone_field.IntlPhoneField(
          key: ValueKey(widget.controller.text),
          controller: widget.controller,
          invalidNumberMessage: AppStrings.pleaseEnterValidPhoneNumber.tr(),
          languageCode: context.locale.languageCode,
          decoration: InputDecoration(
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: AppStrings.yourPhone.tr(),
              counter: const SizedBox.shrink()),
          initialCountryCode: widget.initialCountry,
          onChanged: (value) {
            if (value.number.length == minLength &&
                value.number.length == maxLength) {
              widget.triggerFunction?.call();
            }
          },
          validator: (val) {
            // if (val == null || val.number.isEmpty) {
            //   return AppStrings.pleaseEnterValidPhoneNumber.tr();
            // }
            //? is it needed??
            // if (val.number.length < minLength || val.number.length > maxLength) {
            //   return AppStrings.pleaseEnterValidPhoneNumber.tr();
            // }
            return null;
          },
          onCountryChanged: (country) {
            setState(() {
              minLength = country.minLength;
              maxLength = country.maxLength;
              widget.countryCodeController.text = '+${country.dialCode}';
            });
          },
          disableAutoFillHints: false,
          disableLengthCheck: true,
          keyboardType: TextInputType.phone,
          flagsButtonMargin: const EdgeInsets.symmetric(
            horizontal: AppSizes.s12,
            vertical: AppSizes.s8,
          ),
          dropdownIcon: const Icon(
            Icons.arrow_drop_down,
          ),
          dropdownTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          dropdownIconPosition: intl_phone_field.IconPosition.trailing,
          showCursor: true,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: LocalizationService.isArabic(context: context)
                ? const Border(
                    left: BorderSide(color: Color(0xffE3E5E5), width: 1))
                : const Border(
                    right: BorderSide(color: Color(0xffE3E5E5), width: 1),
                  ),
          ),
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.s16, horizontal: AppSizes.s6),
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
