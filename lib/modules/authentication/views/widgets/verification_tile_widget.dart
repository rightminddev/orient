import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import '../../../../constants/app_strings.dart';

class VerificationTileWidget extends StatelessWidget {
  final Map<String, dynamic> method;
  final VoidCallback onSelected;

  const VerificationTileWidget({
    super.key,
    required this.method,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    String description;
    String subDiscription;

    switch (method.keys.first.toLowerCase()) {
      case 'sms':
        iconData = Icons.sms;
        description = AppStrings.verifyViaSms.tr();
        subDiscription = method.values.first;
        break;
      case 'apps':
        iconData = Icons.notifications;
        description = AppStrings.verifyViaNotificaiton.tr();
        subDiscription = method.values.first;
        break;
      case 'email':
        iconData = Icons.email;
        description = AppStrings.verifyViaEmail.tr();
        subDiscription = method.values.first;
        break;
      case 'auth_app':
        iconData = Icons.safety_check_outlined;
        description = AppStrings.verifyViaAuthenticationApp.tr();
        subDiscription = method.values.first;
        break;
      default:
        iconData = Icons.verified_user;
        description = '${AppStrings.verifyVia.tr()} $method';
        subDiscription = method.values.first;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s10),
      ),
      elevation: 5,
      child: ListTile(
          leading: Icon(
            iconData,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subDiscription,
                style: const TextStyle(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onTap: () => onSelected.call()),
    );
  }
}
