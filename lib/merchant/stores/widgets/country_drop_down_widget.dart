import 'package:flutter/material.dart';

import '../../../models/stores/country_model.dart';
import '../../../utils/components/general_components/all_text_field.dart';

class CountryDropDownWidget extends StatelessWidget {
  final ValueNotifier<String?> countrySelected;
  final List<CountryModel> countries;
  final void Function(CountryModel) onTap;
  const CountryDropDownWidget(
      {super.key,
      required this.countrySelected,
      required this.countries,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: countrySelected,
      builder: (context, countrySelectedValue, child) {
        return defaultDropdownField(
          title: 'store country',
          value: countrySelectedValue,
          items: countries
              .map(
                (element) => DropdownMenuItem<String>(
                  onTap: () {
                    onTap(element);
                    // if (element.iso2 !=
                    //     storeActionsViewModel.createStoreModel.countryId) {
                    //   countrySelected.value = element.title;
                    //   storeActionsViewModel.createStoreModel.countryId =
                    //       element.iso2;
                    //   storeActionsViewModel.createStoreModel.countryKey =
                    //       element.phoneCode;

                    //   statesViewModel
                    //       .initializeStates(context, element.iso2 ?? '')
                    //       .then((_) {
                    //     toggleCountrySelected.value =
                    //         toggleCountrySelected.value != null
                    //             ? !toggleCountrySelected.value!
                    //             : true;
                    //   });
                    // } else {
                    //   //isCountrySelected.value = false;
                    // }
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
        );
      },
    );
  }
}
