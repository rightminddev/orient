import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/app_config.service.dart';
import '../auth_services/authentication.service.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEmailRegister = false;

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

  Future<void> createAccount({required BuildContext context}) async {
    try {
      if (phoneController.text.isEmpty) {
        AlertsService.warning(
            context: context,
            message: AppStrings.phoneNumberIsRequired.tr(),
            title: AppStrings.phoneNumber.tr());
        return;
      }
      if (formKey.currentState?.validate() == true) {
        await _createNewAccount(
            phone: phoneController.text,
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            countryKey: countryCodeController.text.isEmpty
                ? '+02'
                : countryCodeController.text + phoneController.text,
            context: context,
            departmentId: 1);
      } else {
        AlertsService.warning(
            context: context,
            message: AppStrings.formIsInvalid.tr(),
            title: AppStrings.formValidation.tr());
      }
      return;
    } catch (err, t) {
      debugPrint('Error :- $err in :- $t');
      AlertsService.warning(
          context: context,
          message: AppStrings.failedRegisterationPleaseTryAgain.tr(),
          title: AppStrings.failed.tr());

      return;
    }
  }

  Future<void> _createNewAccount(
      {required String name,
      required String phone,
      required String countryKey,
      required String password,
      required String email,
      required int departmentId,
      required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    final result = await AuthenticationService.createAccount(
        context: context,
        name: name,
        phone: phone,
        countryKey: countryKey,
        password: password,
        email: email,
        departmentId: departmentId,
        deviceInformation: appConfigServiceProvider.deviceInformation.toMap());
    if (result.success) {
      Navigator.pop(context, result);
    } else {
      AlertsService.error(
          title: AppStrings.failed.tr(),
          context: context,
          message: result.message ??
              AppStrings.failedRegisterationPleaseTryAgain.tr());

      return;
    }
  }
}
