import 'package:flutter/material.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/fingerprint.model.dart';
import '../../../models/settings/user_settings.model.dart';
import '../../../services/fingerprint_service.dart';

class FingerprintViewModel extends ChangeNotifier {
  List<FingerPrintModel>? fingerprints;
  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeFingerprintScreen(
      {required BuildContext context, String? empId}) async {
    updateLoadingStatus(laodingValue: true);
    UserSettingConst.userSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel;
    await _getEmployeeFingerprints(context: context, empId: empId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getEmployeeFingerprints(
      {required BuildContext context, String? empId}) async {
    // get user fingerprints
    try {
      final result = await FingerprintService.getFingerprints(
          context: context, pfor: empId);
      if (result.success && result.data != null) {
        var fingerprintsData = result.data?['fingerprints'] as List<dynamic>?;
        fingerprints = fingerprintsData
            ?.map((item) =>
                FingerPrintModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting user fingerprints ${err.toString()} at :- $t");
    }
  }
}
