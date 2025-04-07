import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../routing/app_router.dart';
import '../../../services/requests.services.dart';

class ManagementResponseViewModal extends ChangeNotifier {
  final TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> availableActions = [
    {
      "title": RequestManagerActions.approved.name,
      "value": RequestManagerActions.approved.name
    },
    {
      "title": RequestManagerActions.refused.name,
      "value": RequestManagerActions.refused.name
    },
  ];
  Map<String, dynamic>? selectedRequestStatus;

  Future<void> sendManagerAction(
      {required BuildContext context, required String requestId}) async {
    try {
      if (selectedRequestStatus == null) {
        AlertsService.warning(
          context: context,
          message: 'Please Select Action',
          title: 'Warning',
        );
        return;
      }
      if (reasonController.text.isEmpty) {
        AlertsService.warning(
          context: context,
          message: 'Please Enter Reason',
          title: 'Warning',
        );
        return;
      }
      final response = await RequestsServices.managerAction(
          requestId: requestId,
          action: selectedRequestStatus?.values.first,
          replay: reasonController.text,
          context: context);
      if (response.success) {
        AlertsService.success(
            context: context,
            message: response.message ?? 'Action Sent Successfully',
            title: 'Success');
        context.goNamed(AppRoutes.requests.name, pathParameters: {
          'type': 'mine',
          'lang': context.locale.languageCode
        });
      } else {
        AlertsService.error(
            context: context,
            message:
                response.message ?? 'Failed to Send Action, Please Try Later',
            title: 'Error');
        return;
      }
    } catch (ex, t) {
      debugPrint('Error While Sending Manager Action $ex -> $t');
      AlertsService.error(
          context: context,
          message: 'Error While Sending Manager Action, Please Try Later',
          title: 'Error');
      return;
    }
  }
}
