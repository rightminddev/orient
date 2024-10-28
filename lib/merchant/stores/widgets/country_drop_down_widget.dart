import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';

import '../../../models/info/country_model.dart';
import '../../../utils/components/general_components/all_text_field.dart';

class CountryDropDownWidget extends StatelessWidget {
  final ValueNotifier<String?> countrySelected;
  final List<CountryModel> countries;
  final void Function(CountryModel) onTap;
  final bool? isSelected;

  const CountryDropDownWidget(
      {super.key,
      required this.countrySelected,
      required this.countries,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: countrySelected,
      builder: (context, countrySelectedValue, child) {
        return Opacity(
          opacity: isSelected == true ? 1 : 0.5,
          child: defaultDropdownField(
            title: AppStrings.storeCountry.tr(),
            value: countrySelectedValue,
            items: countries
                .map(
                  (element) => DropdownMenuItem<String>(
                    onTap: () {
                      onTap(element);
                    },
                    value: element.title ?? '',
                    child: Text(
                      element.title ?? '',
                      style: TextStyle(
                        color: Color(0xFF464646),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.11,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}
