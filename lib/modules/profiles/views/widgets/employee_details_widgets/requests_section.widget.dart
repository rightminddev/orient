import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../models/employee_profile.model.dart';
import '../profile_balance.widget.dart';

class RequestsSectionWidget extends StatelessWidget {
  final EmployeeProfileModel? employee;
  const RequestsSectionWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH12,
          ProfileBalanceWidget(
            balance: employee?.balance,
            employeeId: employee?.id?.toString(),
          )
        ],
      ),
    );
  }
}
