import 'package:flutter/material.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/settings/user_settings.model.dart';
import '../models/payroll.model.dart';
import '../services/payroll.service.dart';

class PayrollDetailsViewModel extends ChangeNotifier {
  PayrollModel? payroll;
  UserSettingsModel? currentUserSettings;
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializePayrollDetailsScreen(
      {required BuildContext context,
      required String? payrollId,
      String? empId}) async {
    if (payrollId == null) return;
    updateLoadingStatus(laodingValue: true);
    currentUserSettings = (AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context)) as UserSettingsModel;
    await _getPayrollDetailsData(
        context: context, payrollId: payrollId, empId: empId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getPayrollDetailsData(
      {required BuildContext context,
      required String payrollId,
      String? empId}) async {
    try {
      final result = await PayrollService.getSinglePayrollById(
          context: context,
          payrollId: payrollId,
          empId: empId,
          withValues: ['user_id']);
      if (result.success && result.data != null) {
        payroll = PayrollModel.fromJson(result.data?['item']);
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Payroll Details  ${err.toString()} at :- $t");
    }
  }
}
