import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../models/stores/cities_model.dart';
import '../../../utils/components/general_components/all_text_field.dart';

class CityDropDownWidget extends StatelessWidget {
  final bool? isSelected;

  final ValueNotifier<String?> citiesSelected;
  final List<CitiesModel> cities;
  final void Function(List<String>) onListChanged;

  const CityDropDownWidget(
      {super.key,
      required this.isSelected,
      required this.citiesSelected,
      required this.cities,
      required this.onListChanged});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSelected != null ? false : true,
      child: ValueListenableBuilder(
        valueListenable: citiesSelected,
        builder: (context, stateSelectedValue, child) {
          return CustomDropdown<String>.multiSelect(
            items: cities.map((element) => element.title ?? '').toList(),
            initialItems: [],
            onListChanged: (value) {
              onListChanged(value);
              //  log('changing value to: $value');
            },
          );
          // return defaultDropdownField(
          //   title: 'store state',
          //   value: stateSelectedValue,
          //   items: cities
          //       .map(
          //         (element) => DropdownMenuItem<String>(
          //           onTap: () {
          //             onTap(element);
          //           },
          //           value: element.title ?? '',
          //           child: Text(
          //             element.title ?? '',
          //             style: TextStyle(
          //               color: Color(0xFF464646),
          //               fontSize: 12,
          //               fontFamily: 'Poppins',
          //               fontWeight: FontWeight.w400,
          //               height: 0.11,
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          //   onChanged: (value) {},
          // );
        },
      ),
    );
  }
}
