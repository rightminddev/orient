import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../models/payroll.model.dart';

class PayrollDetailsBodyWidget extends StatelessWidget {
  final PayrollModel? payroll;
  const PayrollDetailsBodyWidget({super.key, required this.payroll});

  @override
  Widget build(BuildContext context) {
    String? formatString(String? input) {
      if (input == null || input.trim().isEmpty) return null;

      try {
        // Replace underscores with spaces and trim whitespace
        String normalizedString = input.replaceAll('_', ' ').trim();

        // Capitalize the first letter of each word
        String formattedString = normalizedString.split(' ').map((word) {
          return word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        }).join(' ');

        return formattedString;
      } catch (e) {
        // Handle any potential errors and return null
        return null;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
        child: Column(
          children: [
            gapH24,
            if (payroll?.user?.jobTitle != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Job Title', subtitle: payroll?.user?.jobTitle ?? ''),

            if (payroll?.currency != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Currency', subtitle: payroll?.currency ?? ''),

            if (payroll?.basicSalary != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Basic Salary',
                  subtitle: payroll?.basicSalary?.toString() ?? ''),

            if (payroll?.salaryAdvance != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Salery Advance',
                  subtitle: payroll?.salaryAdvance?.toString() ?? ''),
            // display all deductions
            if (payroll?.payrollDeductions?.isNotEmpty ?? false)
              ...payroll!.payrollDeductions!.map(
                (deduction) => PayrollDetailsBodyTileWidget(
                    title: formatString(deduction.title),
                    subtitle: deduction.value?.toString() ?? ''),
              ),

            // display all bounuses
            if (payroll?.payrollSpecialBonuses?.isNotEmpty ?? false)
              ...payroll!.payrollSpecialBonuses!.map(
                (bonuse) => PayrollDetailsBodyTileWidget(
                    title: formatString(bonuse.title),
                    subtitle: bonuse.value?.toString() ?? ''),
              ),

            if (payroll?.payrollTotalDeductions != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Total Special And Bonuses',
                  subtitle:
                      payroll?.payrollTotalSpecialBonus?.toString() ?? ''),

            if (payroll?.payrollTotalDeductions != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Total Deductions',
                  subtitle: payroll?.payrollTotalDeductions?.toString() ?? ''),

            if (payroll?.netPayable != null)
              PayrollDetailsBodyTileWidget(
                  title: 'Total Salary',
                  subtitle: payroll?.netPayable?.toString() ?? ''),
          ],
        ),
      ),
    );
  }
}

class PayrollDetailsBodyTileWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const PayrollDetailsBodyTileWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s12, vertical: AppSizes.s18),
          decoration: BoxDecoration(
            color: const Color(0x66E5E5E5),
            borderRadius: BorderRadius.circular(AppSizes.s8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AutoSizeText(
                  title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppSizes.s14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              gapW16,
              AutoSizeText(
                subtitle ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.s14,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        gapH16
      ],
    );
  }
}
