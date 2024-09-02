import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../general_services/localization.service.dart';
import '../../../../../utils/animated_custom_dropdown/custom_dropdown.dart';
import '../../../view_models/management_response.viewmodel.dart';

class ManagementResponseModal extends StatelessWidget {
  final String requestId;
  const ManagementResponseModal({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManagementResponseViewModal(),
      child: Consumer<ManagementResponseViewModal>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapH24,
              Center(
                child: Text(
                  AppStrings.managementResponse.tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: AppSizes.s20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              gapH28,
              // request statuses options
              CustomDropdown.search(
                  selectedValue: viewModel.selectedRequestStatus,
                  borderRadius: BorderRadius.circular(AppSizes.s15),
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .enabledBorder
                      ?.borderSide,
                  hintText: AppStrings.requestType.tr(),
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  items: viewModel.availableActions,
                  nameKey: 'title',
                  onChanged: (value) => viewModel.selectedRequestStatus = value,
                  contentPadding: Theme.of(context)
                      .inputDecorationTheme
                      .contentPadding
                      ?.resolve(LocalizationService.isArabic(context: context)
                          ? TextDirection.rtl
                          : TextDirection.ltr)),
              gapH18,
              TextFormField(
                controller: viewModel.reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: AppStrings.reason.tr(),
                ),
              ),
              gapH28,
              Center(
                child: CustomElevatedButton(
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  title: AppStrings.sendRequest.tr(),
                  onPressed: () async => await viewModel.sendManagerAction(
                      requestId: requestId, context: context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
