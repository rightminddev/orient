import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../models/employee_profile.model.dart';
import '../employee_social_icons.widget.dart';
import '../profile_tile.widget.dart';

class ContactsSectionWidget extends StatelessWidget {
  final EmployeeProfileModel? employee;
  const ContactsSectionWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        gapH16,
        if (employee?.phone != null)
          ProfileTile(
            title: employee?.phone ?? '',
          ),
        if (employee?.additionalPhoneNumbers != null &&
            employee?.additionalPhoneNumbers?.isNotEmpty == true)
          ...employee!.additionalPhoneNumbers!.map((phoneNum) => ProfileTile(
                title: phoneNum,
              )),
        if (employee?.email != null && employee?.email?.isNotEmpty == true)
          ProfileTile(
            title: employee?.email ?? '',
          ),
        if (employee?.social != null)
          EmployeeSocialContacts(socialData: employee?.social)
      ],
    );
  }
}
