import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../models/info/cities_model.dart';

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
        },
        closedHeaderPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const CustomDropdownDecoration(
          //listItemDecoration: ListItemDecoration(),
          closedSuffixIcon: Icon(
            Icons.arrow_drop_down_sharp,
            color: Color(0xffE6007E),
          ),
          expandedSuffixIcon: Icon(
            Icons.arrow_drop_up_sharp,
            color: Color(0xffE6007E),
          ),
          hintStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Color(0xFF464646),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0.11,
          ),
          listItemStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Color(0xFF464646),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0.11,
          ),
          headerStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Color(0xFF464646),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            // height: 0.11,
          ),
        ),
      ),
    );
  }
}
