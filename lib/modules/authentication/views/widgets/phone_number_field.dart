import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart' as intl_phone_field;
import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_strings.dart';
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
    return Directionality(
      textDirection: LocalizationService.isArabic(context: context)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: intl_phone_field.IntlPhoneField(
        controller: widget.controller,
        invalidNumberMessage: AppStrings.pleaseEnterValidPhoneNumber.tr(),
        languageCode: context.locale.languageCode,
        decoration: InputDecoration(
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
          if (val == null || val.number.isEmpty) {
            return AppStrings.pleaseEnterValidPhoneNumber.tr();
          }
          if (val.number.length < minLength || val.number.length > maxLength) {
            return AppStrings.pleaseEnterValidPhoneNumber.tr();
          }
          return null;
        },
        onCountryChanged: (country) {
          setState(() {
            minLength = country.minLength;
            maxLength = country.maxLength;
          });
          widget.countryCodeController.text = '+${country.dialCode}';
        },
        disableAutoFillHints: false,
        disableLengthCheck: false,
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
          border: LocalizationService.isArabic(context: context)
              ? const Border(
                  left: BorderSide(color: Color(0xffDFDFDF), width: 1.4))
              : const Border(
                  right: BorderSide(color: Color(0xffDFDFDF), width: 1.4),
                ),
        ),
        pickerDialogStyle: PickerDialogStyle(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              vertical: AppSizes.s16, horizontal: AppSizes.s6),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
