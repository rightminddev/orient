import 'package:flutter/material.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/settings/user_settings.model.dart';
import '../models/payroll.model.dart';
import '../services/payroll.service.dart';

class PayrollsListViewModel extends ChangeNotifier {
  List<PayrollModel>? payrolls;
  UserSettingsModel? userSettings;

  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializePayrollsListScreen(
      {required BuildContext context, required String? empId}) async {
    updateLoadingStatus(laodingValue: true);
    userSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel;
    await _getPayrolls(context: context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getPayrolls(
      {required BuildContext context, String? empId}) async {
    // get user Payrolls
    try {
      final result = await PayrollService.getPayrollsList(
          context: context, empId: empId, withValues: ['user_id']);
      if (result.success && result.data != null) {
        var payrollsListData = result.data?['data'] as List<dynamic>?;
        payrolls = payrollsListData
            ?.map((item) => PayrollModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting user payrolls list ${err.toString()} at :- $t");
    }
  }
}
