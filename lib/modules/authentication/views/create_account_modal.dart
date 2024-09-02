import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/validation_service.dart';
import '../view_models/create_account.viewmodel.dart';
import 'widgets/phone_number_field.dart';
import 'widgets/switch_row_widget.dart';

class CreateAccountModal extends StatefulWidget {
  const CreateAccountModal({super.key});

  @override
  State<CreateAccountModal> createState() => _CreateAccountModalState();
}

class _CreateAccountModalState extends State<CreateAccountModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateAccountViewModel>(
        create: (_) => CreateAccountViewModel(),
        child: Consumer<CreateAccountViewModel>(
            builder: (context, viewModel, child) {
          return Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH20,
                PhoneNumberField(
                  controller: viewModel.phoneController,
                  countryCodeController: viewModel.countryCodeController,
                ),
                gapH4,
                SwitchRow(
                  value: false,
                  onChanged: (newValue) => setState(() {}),
                  leftText: AppStrings.smsActive.tr(),
                  rightText: AppStrings.whatsAppActive.tr(),
                ),
                gapH20,
                TextFormField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    hintText: AppStrings.yourEmail.tr(),
                  ),
                  validator: (val) => ValidationService.validateEmail(val),
                ),
                gapH20,
                TextFormField(
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                    hintText: AppStrings.password.tr(),
                  ),
                  obscureText: true,
                  validator: (val) => ValidationService.validatePassword(val),
                ),
                gapH20,
                TextFormField(
                  controller: viewModel.nameController,
                  decoration: InputDecoration(
                    hintText: AppStrings.yourName.tr(),
                  ),
                  validator: (val) => ValidationService.validateRequired(val),
                ),
                gapH28,
                Center(
                    child: CustomElevatedButton(
                        isPrimaryBackground: false,
                        title: AppStrings.create.tr(),
                        onPressed: () async =>
                            viewModel.createAccount(context: context))),
                gapH32,
              ],
            ),
          );
        }));
  }
}
