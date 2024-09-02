import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common_modules_widgets/vocation_list.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../models/settings/user_settings_2.model.dart';
import '../../../view_models/statistics.viewmodel.dart';

class StatisticsModal extends StatelessWidget {
  final String employeeId;
  final List<MapEntry<String, Balance>> empVocationBalance;
  const StatisticsModal(
      {super.key, required this.employeeId, required this.empVocationBalance});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatisticsViewModel(),
      child: Consumer<StatisticsViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapH24,
              Center(
                child: Text(
                  AppStrings.statistics.tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: AppSizes.s20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              gapH28,
              StatisticsBalanceList(
                vacationBalance: empVocationBalance,
                employeeId: employeeId,
              )
            ],
          );
        },
      ),
    );
  }
}

class StatisticsBalanceList extends StatelessWidget {
  final List<MapEntry<String, Balance>>? vacationBalance;
  final double? paddingBetweenVocations;
  final double? sectionPadding;
  final String? employeeId;
  const StatisticsBalanceList({
    this.vacationBalance,
    super.key,
    this.employeeId,
    this.paddingBetweenVocations = AppSizes.s12,
    this.sectionPadding = AppSizes.s32,
  });

  @override
  Widget build(BuildContext context) {
    return vacationBalance == null || vacationBalance?.isEmpty == true
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.s32),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: vacationBalance!
                    .map((entry) => Padding(
                          padding:
                              EdgeInsets.only(right: paddingBetweenVocations!),
                          child: VacationCard(
                            userId: employeeId,
                            vocation: entry,
                            sectionPadding: sectionPadding,
                            paddingBetweenVocations: paddingBetweenVocations,
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
  }
}
