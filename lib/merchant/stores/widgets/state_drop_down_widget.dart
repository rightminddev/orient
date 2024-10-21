import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/models/info/state_model.dart';

import '../../../utils/components/general_components/all_text_field.dart';

class StateDropDownWidget extends StatelessWidget {
  final bool? isSelected;

  final ValueNotifier<String?> stateSelected;
  final List<StateModel> states;
  final void Function(StateModel) onTap;

  const StateDropDownWidget(
      {super.key,
      required this.isSelected,
      required this.stateSelected,
      required this.states,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSelected != null ? false : true,
      child: ValueListenableBuilder(
        valueListenable: stateSelected,
        builder: (context, stateSelectedValue, child) {
          return defaultDropdownField(
            title: AppStrings.storeGovernorate.tr(),
            value: stateSelectedValue,
            items: states
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
          );
        },
      ),
    );
  }
}
