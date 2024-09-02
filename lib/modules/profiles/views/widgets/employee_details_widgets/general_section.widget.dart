import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../routing/app_router.dart';
import '../../../models/employee_profile.model.dart';
import '../profile_tile.widget.dart';

class GeneralSectionWidget extends StatelessWidget {
  final EmployeeProfileModel? employee;
  const GeneralSectionWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.secondary,
      fontSize: AppSizes.s14,
    );
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH12,
          if (employee?.jobDescription != null &&
              employee?.jobDescription?.isNotEmpty == true) ...[
            AutoSizeText(
              'JOB DESCRIPTION',
              style: textStyle,
            ),
            gapH8,
            AutoSizeText(employee!.jobDescription!),
            gapH12,
          ],
          if ((employee?.hireDate != null &&
                  employee?.hireDate?.isNotEmpty == true) ||
              (employee?.workingHoursType != null &&
                  employee?.workingHoursType?.isNotEmpty == true) ||
              (employee?.workingHoursType != null &&
                  employee?.workingHours?.dailyWorkingHours?.isNotEmpty ==
                      true) ||
              (employee?.weekends != null &&
                  employee?.weekends?.isNotEmpty == true)) ...[
            AutoSizeText(
              'GENERAL INFO',
              style: textStyle,
            ),
            gapH8,
            //HIRE DATE
            if (employee?.hireDate != null &&
                employee?.hireDate?.isNotEmpty == true)
              ProfileTile(
                isTitleOnly: false,
                title: 'HIRE DATE',
                trailingTitle: employee!.hireDate,
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            //WORK HOURS TYPE
            if (employee?.workingHoursType != null &&
                employee?.workingHoursType?.isNotEmpty == true)
              ProfileTile(
                isTitleOnly: false,
                title: 'WORK HOURS TYPE',
                trailingTitle: employee?.workingHoursType ?? '',
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            // WORK HOURS
            if (employee?.workingHoursType != null &&
                employee?.workingHours?.dailyWorkingHours?.isNotEmpty == true)
              ProfileTile(
                isTitleOnly: false,
                title: 'WORK HOURS',
                trailingTitle: employee?.workingHours?.dailyWorkingHours ?? '',
                icon: const Icon(Icons.calendar_month_outlined),
              ),
            //WEEKENDS
            if (employee?.weekends != null &&
                employee?.weekends?.isNotEmpty == true)
              ProfileTile(
                isTitleOnly: false,
                title: 'WEEKENDS',
                trailingTitle: employee?.weekends ?? '',
                icon: const Icon(Icons.calendar_month_outlined),
              ),
          ],
          gapH24,
          Center(
              child: CustomElevatedButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  titleSize: AppSizes.s12,
                  title: 'VIEW FINGERPRINTS',
                  onPressed: () async => await context
                          .pushNamed(AppRoutes.fingerprint.name, extra: {
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
