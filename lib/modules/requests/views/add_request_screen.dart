import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../general_services/localization.service.dart';
import '../../../utils/animated_custom_dropdown/custom_dropdown.dart';
import '../view_models/add_new_request.viewmodel.dart';
import 'widgets/custom_request_details_button.widget.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  late final AddNewRequestViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AddNewRequestViewModel();
    viewModel.initializeAddNewRequestScreen(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.secondary,
      fontSize: AppSizes.s14,
    );
    return ChangeNotifierProvider<AddNewRequestViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          pageContext: context,
          title: AppStrings.newRequest.tr(),
          body: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.s16, horizontal: AppSizes.s12),
              child: Consumer<AddNewRequestViewModel>(
                builder: (context, viewModel, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.mainData.tr(),
                            style: textStyle,
                          ),
                          gapH14,
                          CustomDropdown.search(
                              selectedValue: viewModel.selectedRequestType,
                              borderRadius: BorderRadius.circular(AppSizes.s15),
                              borderSide: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder
                                  ?.borderSide,
                              hintText: AppStrings.requestType.tr(),
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              items: viewModel.requestsTypes,
                              nameKey: "title",
                              onChanged: (value) =>
                                  viewModel.selectedRequestType = value,
                              contentPadding: Theme.of(context)
                                  .inputDecorationTheme
                                  .contentPadding
                                  ?.resolve(LocalizationService.isArabic(
                                          context: context)
                                      ? TextDirection.rtl
                                      : TextDirection.ltr)),
                          gapH14,
                          viewModel.selectedRequestType?['type'] ==
                                  'instead_of_holidays'
                              ? CustomDropdown.search(
                                  selectedValue: viewModel.selectedRequestType,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s15),
                                  borderSide: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder
                                      ?.borderSide,
                                  hintText: AppStrings.requestTime.tr(),
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                  items: viewModel.requestsTypes,
                                  nameKey: "name",
                                  onChanged: (value) =>
                                      viewModel.selectInsteadOfHolidays(context,
                                          startDateOrDatetime: value['from'],
                                          endDateOrDatetime: value['to']),
                                  contentPadding: Theme.of(context)
                                      .inputDecorationTheme
                                      .contentPadding
                                      ?.resolve(LocalizationService.isArabic(
                                              context: context)
                                          ? TextDirection.rtl
                                          : TextDirection.ltr))
                              : TextField(
                                  controller: viewModel.controller,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.requestTime.tr(),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () =>
                                          viewModel.selectDate(context),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () => viewModel.selectDate(context),
                                ),
                          gapH14,
                          TextFormField(
                            controller: viewModel.reasonController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: AppStrings.reason.tr(),
                            ),
                          ),
                          gapH14,
                          Consumer<AddNewRequestViewModel>(
                              builder: (context, viewModel, child) {
                            final attachingFile =
                                (viewModel.selectedRequestType?['fields']
                                        ?['attaching_file'] as String?)
                                    ?.toLowerCase()
                                    .trim();
                            final moneyValue =
                                (viewModel.selectedRequestType?['fields']
                                        ?['money_value'] as String?)
                                    ?.toLowerCase()
                                    .trim();
                            return (attachingFile == 'active' ||
                                        attachingFile == 'required' ||
                                        attachingFile == 'optional') ||
                                    (moneyValue == 'active' ||
                                        moneyValue == 'required' ||
                                        moneyValue == 'optional')
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.additionalData.tr(),
                                        style: textStyle,
                                      ),
                                      gapH14,
                                      if (attachingFile == 'active' ||
                                          attachingFile == 'required' ||
                                          attachingFile == 'optional')
                                        TextFormField(
                                          controller: viewModel.fileController,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppStrings.uploadFiles.tr(),
                                            suffixIcon: IconButton(
                                              icon:
                                                  const Icon(Icons.upload_file),
                                              onPressed: () async =>
                                                  viewModel.pickFile(),
                                            ),
                                          ),
                                          readOnly: true,
                                          onTap: () async =>
                                              await viewModel.pickFile(),
                                        ),
                                      gapH14,
                                      if (moneyValue == 'active' ||
                                          moneyValue == 'required' ||
                                          moneyValue == 'optional')
                                        TextFormField(
                                          controller:
                                              viewModel.amountController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: AppStrings.amount.tr(),
                                          ),
                                        )
                                    ],
                                  )
                                : const SizedBox.shrink();
                          }),
                          gapH14,
                          Text(viewModel.notes ?? ''),
                        ],
                      ),
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s6, horizontal: AppSizes.s16),
                      width: LayoutService.getWidth(context),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(AppSizes.s50)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            gapW12,
                            Expanded(
                                child: Text(
                              '${viewModel.duration?.toString() ?? 0} ${viewModel.getHoursOrDayesStringDependsOnRequestType()}',
                              style: textStyle.copyWith(color: Colors.white),
                            )),
                            gapW8,
                            CustomRequestDetailsButton(
                              title: AppStrings.sendRequest.tr(),
                              onPressed: () async =>
                                  viewModel.createNewRequest(context: context),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
