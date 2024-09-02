import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../routing/app_router.dart';
import '../../../models/employee_profile.model.dart';
import '../profile_tile.widget.dart';

class AccountsSectionWidget extends StatelessWidget {
  final EmployeeProfileModel? employee;
  const AccountsSectionWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH12,
          if ((employee?.basicSalary != null ||
                  employee?.basicSalary?.isNotEmpty == true) ||
              employee?.additions != null ||
              employee?.totalDeductions != null ||
              employee?.netSalary != null) ...[
            //HIRE DATE
            if (employee?.basicSalary != null)
              ProfileTile(
                isTitleOnly: false,
                title: 'BASIC SALLERY',
                trailingTitle: employee?.basicSalary.toString(),
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            //WORK HOURS TYPE
            if (employee?.additions != null)
              ProfileTile(
                isTitleOnly: false,
                title: 'ADDITIONS',
                trailingTitle: employee?.additions.toString(),
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            // WORK HOURS
            if (employee?.totalDeductions != null)
              ProfileTile(
                isTitleOnly: false,
                title: 'TOTAL DEDUCTIONS',
                trailingTitle: employee?.totalDeductions.toString(),
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            //WEEKENDS
            if (employee?.netSalary != null)
              ProfileTile(
                isTitleOnly: false,
                title: 'NET SALARY PAYABLE',
                trailingTitle: employee?.netSalary.toString() ?? '',
                icon: const Icon(Icons.calendar_month_outlined),
              ),
          ],
          gapH24,
          Center(
              child: CustomElevatedButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  titleSize: AppSizes.s12,
                  title: 'VIEW PAYROLLS',
                  onPressed: () async => await context
                          .pushNamed(AppRoutes.payrollsList.name, extra: {
                        'employeeName': employee?.name,
                        'employeeId': employee?.id?.toString()
                      }, pathParameters: {
                        'lang': context.locale.languageCode
                      }))),
        ],
      ),
    );
  }
}
