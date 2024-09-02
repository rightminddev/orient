import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/validation_service.dart';
import '../view_models/forgot_password.viewmodel.dart';
import 'widgets/phone_number_field.dart';
import 'widgets/switch_row_widget.dart';
import 'widgets/verification_tile_widget.dart';

class ForgotPasswordModal extends StatelessWidget {
  final bool isPhoneLogin;
  const ForgotPasswordModal({super.key, required this.isPhoneLogin});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordViewModel>(
      create: (_) => ForgotPasswordViewModel()..init(isPhoneLogin),
      child: Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!viewModel.goToChooseForgotMethod && !viewModel.codeSent) ...[
                SwitchRow(
                  value: viewModel.isPhoneLogin,
                  onChanged: (newValue) =>
                      viewModel.toggleLoginMethod(newValue),
                ),
                gapH24,
                viewModel.isPhoneLogin
                    ? PhoneNumberField(
                        controller: viewModel.phoneController,
                        countryCodeController: viewModel.countryCodeController,
                      )
                    : TextFormField(
                        controller: viewModel.emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.yourEmail.tr()),
                        validator: (value) =>
                            ValidationService.validateEmail(value),
                      ),
                gapH26,
                Center(
                  child: CustomElevatedButton(
                    isPrimaryBackground: false,
                    title: AppStrings.send.tr(),
                    onPressed: () => viewModel.prepeareForgotPassword(context),
                  ),
                ),
                gapH28,
              ] else if (!viewModel.codeSent &&
                  viewModel.goToChooseForgotMethod &&
                  viewModel.forgotPasswordMethods != null &&
                  (viewModel.forgotPasswordMethods?.isNotEmpty ?? false)) ...[
                ...viewModel.forgotPasswordMethods!.entries.map((m) {
                  final method = {m.key: m.value};
                  return VerificationTileWidget(
                      method: method,
                      onSelected: () async {
                        viewModel.sendType = method.keys.first;
                        await viewModel.chooseForgotPasswordMethod(
                            context: context);
                      });
                }),
              ] else if (viewModel.codeSent) ...[
                Form(
                    key: viewModel.codeFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: viewModel.codeController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: AppStrings.code.tr()),
                          validator: (value) =>
                              ValidationService.validateRequired(value),
                        ),
                        gapH20,
                        TextFormField(
                          controller: viewModel.newPasswordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.newPassword.tr()),
                          obscureText: true,
                          validator: (value) =>
                              ValidationService.validatePassword(value),
                        ),
                      ],
                    )),
                gapH20,
                Center(
                  child: CustomElevatedButton(
                    isPrimaryBackground: false,
                    title: AppStrings.send.tr(),
                    onPressed: () async =>
                        await viewModel.resetNewPasswordWithCodeAndNewPassword(
                            context: context),
                  ),
                ),
                gapH28,
              ],
            ],
          );
        },
      ),
    );
  }
}
