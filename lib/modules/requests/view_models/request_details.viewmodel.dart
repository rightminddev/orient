import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/operation_result.model.dart';
import '../../../models/settings/user_settings.model.dart';
import '../../../models/settings/user_settings_2.model.dart';
import '../../../routing/app_router.dart';
import '../../../services/requests.services.dart';
import '../../../utils/modal_sheet_helper.dart';
import '../views/widgets/modals/statistics.modal.dart';

class RequestDetailsViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  UserSettingsModel? userSettings;

  void initializeRequestDetails({required BuildContext context}) {
    userSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel?;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> showAndGetEmployeeStatistics(
      BuildContext context, String empId) async {
    // First get the employee balance
    List<MapEntry<String, Balance>>? empVocationBalance =
        await getEmployeeVocationBalance(context: context, empId: empId);
    if (empVocationBalance == null || empVocationBalance.isEmpty) {
      AlertsService.info(
          context: context,
          message: 'Employee has no vocation balance',
          title: 'Info');
      return;
    }
    // finally if the employee balance getten successfully , then show statistics modal and pass balance to it
    await ModalSheetHelper.showModalSheet(
        context: context,
        modalContent: StatisticsModal(
            employeeId: empId, empVocationBalance: empVocationBalance),
        title: 'Statistics',
        height: AppSizes.s300);
  }

  Future<List<MapEntry<String, Balance>>?> getEmployeeVocationBalance(
      {required BuildContext context, required String empId}) async {
    try {
      final result = await RequestsServices.getEmployeeBalance(
          context: context, empId: empId);
      if (result.success) {
        final balanceData = result.data?['balance'];
        if (balanceData is Map<String, dynamic>) {
          return balanceData.entries.map((entry) {
            return MapEntry(entry.key, Balance.fromJson(entry.value));
          }).toList();
        } else {
          AlertsService.error(
              context: context,
              message: 'Unexpected data format for balance',
              title: 'Error');
          return null;
        }
      } else {
        AlertsService.error(
            context: context,
            message: result.message ?? 'Failed to get vocation balance',
            title: 'Error');
        return null;
      }
    } catch (ex, t) {
      debugPrint(
          'Error while getting Vocation Balance of employee $empId , error :- ${ex.toString()} in $t');
      AlertsService.error(
          context: context,
          message: 'Error while getting Vocation Balance of employee',
          title: 'Error');
      return null;
    }
  }

  Future<void> askToIgnore(
      {required BuildContext context, String? requestId}) async {
    if (requestId == null) return;
    try {
      OperationResult<Map<String, dynamic>> result =
          await RequestsServices.askIgnore(
              requestId: requestId, context: context);
      if (result.success) {
        await AlertsService.success(
            title: 'Success !',
            context: context,
            message: result.message ?? 'Asking to Ignore Sending Successfully');
        context.goNamed(AppRoutes.requests.name, pathParameters: {
          'type': 'mine',
          'lang': context.locale.languageCode
        });
        return;
      } else {
        AlertsService.error(
            title: 'Failed',
            context: context,
            message:
                result.message ?? 'Failed Sending Ignore Request , try later!');
        return;
      }
    } catch (ex) {
      AlertsService.error(
          context: context, message: ex.toString(), title: 'Failed !');
      return;
    }
  }

  Future<void> askToRemember(
      {required BuildContext context, String? requestId}) async {
    if (requestId == null) return;
    try {
      OperationResult<Map<String, dynamic>> result =
          await RequestsServices.askRemember(
              requestId: requestId, context: context);
      if (result.success) {
        await AlertsService.success(
            title: 'Success !',
            context: context,
            message:
                result.message ?? 'Asking to Remember Sending Successfully');
        context.goNamed(AppRoutes.requests.name, pathParameters: {
          'type': 'mine',
          'lang': context.locale.languageCode
        });
        return;
      } else {
        AlertsService.error(
            title: 'Failed !',
            context: context,
            message:
                result.message ?? 'Failed Sending Ask to Remeber , try later!');
        return;
      }
    } catch (ex) {
      AlertsService.error(
          context: context, message: ex.toString(), title: 'Failed !');
      return;
    }
  }

  Future<void> askToComplain(
      {required BuildContext context, required String? requestId}) async {
    await AlertsService.info(
        context: context,
        message: 'This Feature Under Development',
        title: 'Information');
  }
}
