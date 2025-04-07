import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';

import '../../../models/info/country_model.dart';

class CountryDropDownWidget extends StatefulWidget {
  final ValueNotifier<String?> countrySelected;
  final List<CountryModel> countries;
  final void Function(CountryModel) onTap;
  final bool? isSelected;
  final String? title;

  const CountryDropDownWidget({
    super.key,
    this.title,
    required this.countrySelected,
    required this.countries,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _CountryDropDownWidgetState createState() => _CountryDropDownWidgetState();
}

class _CountryDropDownWidgetState extends State<CountryDropDownWidget> {
  final TextEditingController searchController = TextEditingController();
  List<CountryModel> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.countries;
  }

  void filterCountries(String query) {
    setState(() {
      // Filter countries based on the query
      filteredCountries = widget.countries
          .where((country) => country.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();

      // If no countries match the query
      if (filteredCountries.isEmpty) {
        // Reset the selection or set to a default value
        widget.countrySelected.value = null; // or set to a specific default
      } else {
        // Ensure the selected value is still valid
        if (!filteredCountries.any((country) => country.title == widget.countrySelected.value)) {
          widget.countrySelected.value = filteredCountries.first.title; // or null if you prefer
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.countrySelected,
      builder: (context, countrySelectedValue, child) {
        if (!filteredCountries.map((e) => e.title).contains(countrySelectedValue)) {
          widget.countrySelected.value = filteredCountries.isNotEmpty ? filteredCountries.first.title : null;
        }
        return Opacity(
          opacity: widget.isSelected == true ? 1 : 0.5,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 18, left: 0),
            decoration: ShapeDecoration(
              color: AppThemeService.colorPalette.tertiaryColorBackground.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.s10),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(widget.title ?? AppStrings.storeCountry.tr(),style: const TextStyle(
                  color: Color(0xFF464646),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),),
                value: countrySelectedValue ?? "",
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Color(0xffE6007E),
                  ),
                ),
                items: filteredCountries.map((element) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      widget.onTap(element);
                      // Reset search field after selection
                      searchController.clear();
                      setState(() {
                        filteredCountries = widget.countries;
                      });
                    },
                    value: element.title ?? '',
                    child: Text(
                      element.title ?? '',
                      style: const TextStyle(
                        color: Color(0xFF464646),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {},
                dropdownSearchData: DropdownSearchData(
                  searchController: searchController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search country...",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (query) => filterCountries(query),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    print("HHH");
                    return item.value
                        .toString()
                        .contains(searchValue);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}