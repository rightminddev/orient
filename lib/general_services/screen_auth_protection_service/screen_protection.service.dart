import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/settings/general_settings.model.dart';
import '../app_config.service.dart';
import '../settings.service.dart';
import 'local_auth.service.dart';

class ScreenProtection {
  Future<bool> getValueFromSettings({required BuildContext context}) async {
    bool? isPayrollScreenProtection = (AppSettingsService.getSettings(
            settingsType: SettingsType.generalSettings,
            context: context) as GeneralSettingsModel)
        .payrollScreenProtection;
    return isPayrollScreenProtection == true;
  }

  Future<bool> enableScreenProtection(
      {required bool mounted, required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    bool isProtected = await getValueFromSettings(context: context);
    if (isProtected) {
      try {
        bool isSupported = await LocalAuthenticationService.isDeviceSupported();
        if (!isSupported) return false;

        bool canCheckBiometrics =
            await LocalAuthenticationService.canCheckBiometrics();
        if (!canCheckBiometrics) return false;

        bool authenticated =
            await LocalAuthenticationService.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint (or face) to authenticate',
        );

        if (!authenticated) {
          authenticated =
              await LocalAuthenticationService.authenticateWithBiometrics(
            localizedReason: 'Authenticate using biometrics',
          );
          if (authenticated) {
            appConfigServiceProvider.protectionDate = DateTime.now().toString();
          }
          return authenticated;
        } else {
          appConfigServiceProvider.protectionDate = DateTime.now().toString();
          return true;
        }
      } catch (e) {
        debugPrint("Error enabling screen protection: $e");
        return false;
      }
    }
    return false;
  }
}
