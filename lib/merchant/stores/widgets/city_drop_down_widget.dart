import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../models/stores/cities_model.dart';

class CityDropDownWidget extends StatelessWidget {
  final bool? isSelected;

  final List<CitiesModel> cities;
  final void Function(List<String>) onListChanged;
  final List<String>? initialItems;

  const CityDropDownWidget({
    super.key,
    required this.isSelected,
    required this.cities,
    required this.onListChanged,
    this.initialItems,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSelected != null ? false : true,
      child: CustomDropdown<String>.multiSelect(
        items: cities.map((element) => element.title ?? '').toList(),
        initialItems: initialItems ?? [],
        onListChanged: (value) {
          List<String> ids = List.empty(growable: true);
          for (var element in value) {
            ids.add((cities.firstWhere((city) => element == city.title).id ?? 0)
                .toString());
          }
          onListChanged(ids);

          //  log('changing value to: $value');

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
