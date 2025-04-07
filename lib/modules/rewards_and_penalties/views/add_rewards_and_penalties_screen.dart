import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/localization.service.dart';
import '../../../utils/animated_custom_dropdown/custom_dropdown.dart';
import '../view_models/add_reward_and_penalty.viewmodel.dart';

class AddRewardAndPenaltyScreen extends StatefulWidget {
  const AddRewardAndPenaltyScreen({super.key});

  @override
  State<AddRewardAndPenaltyScreen> createState() =>
      _AddRewardAndPenaltyScreenState();
}

class _AddRewardAndPenaltyScreenState extends State<AddRewardAndPenaltyScreen> {
  late final AddRewardAndPenaltyViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AddRewardAndPenaltyViewModel();
    viewModel.initializeAddRewardAndPenaltyScreen(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRewardAndPenaltyViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          pageContext: context,
          title: 'Add Reward and Penalty',
          body: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.s16, horizontal: AppSizes.s12),
              child: Consumer<AddRewardAndPenaltyViewModel>(
                builder: (context, viewModel, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH14,
                    //Date Field
                    TextField(
                      controller: viewModel.selectedDatecontroller,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => viewModel.selectDate(context),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => viewModel.selectDate(context),
                    ),
                    gapH14,
                    CustomDropdown.search(
                        selectedValue: viewModel.selectedType,
                        borderRadius: BorderRadius.circular(AppSizes.s15),
                        borderSide: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder
                            ?.borderSide,
                        hintText: 'Type',
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.hintStyle,
                        items: viewModel.types,
                        nameKey: "name",
                        onChanged: (value) => viewModel.selectedType = value,
                        contentPadding: Theme.of(context)
                            .inputDecorationTheme
                            .contentPadding
                            ?.resolve(
                                LocalizationService.isArabic(context: context)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr)),
                    gapH14,
                    CustomDropdown.search(
                        selectedValue: viewModel.selectedCategory,
                        borderRadius: BorderRadius.circular(AppSizes.s15),
                        borderSide: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder
                            ?.borderSide,
                        hintText: 'Category',
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.hintStyle,
                        items: viewModel.categories,
                        nameKey: "name",
                        onChanged: (value) =>
                            viewModel.selectedCategory = value,
                        contentPadding: Theme.of(context)
                            .inputDecorationTheme
                            .contentPadding
                            ?.resolve(
                                LocalizationService.isArabic(context: context)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr)),

                    gapH14,
                    // Reason
                    TextFormField(
                      controller: viewModel.reasonController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppStrings.reason.tr(),
                      ),
                    ),
                    //TODO:ADDING EMPLOYEE THAT MANAGED BY ME IN DROPDOWN
                    gapH14,
                    TextFormField(
                      controller: viewModel.amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AppStrings.amount.tr(),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          titleSize: AppSizes.s14,
                          radius: AppSizes.s24,
                          title: 'Send',
                          onPressed: () async => viewModel
                              .createRewardAndPenalty(context: context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
