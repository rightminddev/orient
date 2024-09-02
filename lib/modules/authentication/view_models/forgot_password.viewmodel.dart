import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/app_config.service.dart';
import '../auth_services/forgot_password.service.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  bool goToChooseForgotMethod = false;
  bool codeSent = false;
  bool isPhoneLogin = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
  Map<String, dynamic>? forgotPasswordMethods;
  String? uuid;
  String? sendType;

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

  void init(bool isPhoneLogin) {
    this.isPhoneLogin = isPhoneLogin;
  }

  void toggleLoginMethod(bool newValue) {
    isPhoneLogin = newValue;
    notifyListeners();
  }

  // First : prepare forgot password operation
  Future<void> prepeareForgotPassword(BuildContext context) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if ((isPhoneLogin && phoneController.text.isNotEmpty) ||
        (!isPhoneLogin && emailController.text.isNotEmpty)) {
      final result = await ForgotPasswordService.prepareForgetPassword(
          context: context,
          username: isPhoneLogin ? phoneController.text : emailController.text,
          deviceUniqueId:
              appConfigServiceProvider.deviceInformation.deviceUniqueId);
      if (result.success &&
          result.data != null &&
          result.data?['forgot_password_prepare'] == true &&
          (result.data?['uuid'] != null && result.data?['uuid'] != '') &&
          (result.data?['forgot_password_methods'] != null &&
              result.data?['forgot_password_methods'] != {})) {
        forgotPasswordMethods = result.data?['forgot_password_methods'];
        uuid = result.data?['uuid'];
        goToChooseForgotMethod = true;
        notifyListeners();
        return;
      } else {
        AlertsService.error(
          title: AppStrings.failed.tr(),
          context: context,
          message: result.message ??
              AppStrings.failedPreparingToForgotPasswordPleaseTryAgain.tr(),
        );

        return;
      }
    } else {
      AlertsService.warning(
        context: context,
        message: AppStrings.formIsInvalid.tr(),
        title: AppStrings.formValidation.tr(),
      );
      return;
    }
  }

  // second : choose forgot password verification method
  Future<void> chooseForgotPasswordMethod(
      {required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if (uuid == null ||
        (uuid?.isEmpty ?? true) ||
        sendType == null ||
        (sendType?.isEmpty ?? true)) {
      AlertsService.error(
        title: AppStrings.error.tr(),
        context: context,
        message: AppStrings.invalidUUIDOrSentType.tr(),
      );
      return;
    }
    AlertsService.showLoading(context);
    final completePhoneNumber = (countryCodeController.text.isEmpty
            ? '+02'
            : countryCodeController.text + phoneController.text)
        .trim();
    final result = await ForgotPasswordService.forgetPassword(
        context: context,
        username: isPhoneLogin ? completePhoneNumber : emailController.text,
        sendType: sendType!,
        uuid: uuid!,
        deviceUniqueId:
            appConfigServiceProvider.deviceInformation.deviceUniqueId);
    Navigator.pop(context);

    if (result.success && result.data != null) {
      codeSent = true;
      notifyListeners();
      return;
    } else {
      AlertsService.error(
        title: AppStrings.failed.tr(),
        context: context,
        message: result.message ??
            AppStrings.failedSendForgotPasswordCodePleaseTryAgain.tr(),
      );

      return;
    }
  }

  // Finally send new password and forgot password verification code to reset forgotten password with the new password
  Future<void> resetNewPasswordWithCodeAndNewPassword(
      {required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if (codeFormKey.currentState?.validate() == true) {
      final completePhoneNumber = (countryCodeController.text.isEmpty
              ? '+02'
              : countryCodeController.text + phoneController.text)
          .trim();
      final result = await ForgotPasswordService.codeNewPassword(
          context: context,
          code: codeController.text,
          newPassword: newPasswordController.text,
          username: isPhoneLogin ? completePhoneNumber : emailController.text,
          sendType: sendType!,
          uuid: uuid!,
          deviceUniqueId:
              appConfigServiceProvider.deviceInformation.deviceUniqueId);
      if (result.success && result.data != null) {
        Navigator.pop(context, result);

        return;
      } else {
        AlertsService.error(
          title: AppStrings.failed.tr(),
          context: context,
          message: result.message ??
              AppStrings.failedVerifingForgotPasswordCodePleaseTryAgain.tr(),
        );

        return;
      }
    }
  }
}
