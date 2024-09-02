import 'package:flutter/material.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/settings/user_settings.model.dart';
import '../models/employee_profile.model.dart';
import '../services/employee.service.dart';

class EmployeeDetailsViewModel extends ChangeNotifier {
  EmployeeProfileModel? employee;
  UserSettingsModel? currentUserSettings;
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeEmployeesListScreen(
      {required BuildContext context, required String employeeId}) async {
    updateLoadingStatus(laodingValue: true);
    currentUserSettings = (AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context)) as UserSettingsModel;
    await _getEmployeeData(context: context, employeeId: employeeId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getEmployeeData(
      {required BuildContext context, required String employeeId}) async {
    try {
      final result = await EmployeeService.getEmployeeData(
          context: context, employeeId: employeeId);
      if (result.success && result.data != null) {
        employee = EmployeeProfileModel.fromJson(result.data?['employee']);
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
