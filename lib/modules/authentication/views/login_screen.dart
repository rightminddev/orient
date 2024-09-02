import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../common_modules_widgets/language_dropdown_button.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/app_config.service.dart';
import '../../../general_services/layout.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../general_services/validation_service.dart';
import '../../../models/settings/general_settings.model.dart';
import '../../../utils/overlay_gradient_widget.dart';
import '../view_models/login.viewmodel.dart';
import 'widgets/phone_number_field.dart';
import 'widgets/switch_row_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AuthenticationViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AuthenticationViewModel();
    viewModel.initializeAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationViewModel>(
        create: (context) => viewModel,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SizedBox(
              height: LayoutService.getHeight(context),
              width: LayoutService.getWidth(context),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: viewModel.animation,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: FractionallySizedBox(
                          widthFactor: AppSizes.s4,
                          alignment:
                              Alignment((viewModel.animation.value * 2) - 1, 0),
                          child: Image.asset(
                            AppImages.loginBackground,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  const OverlayGradientWidget(),
                  Center(
                    child: Form(
                      key: viewModel.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.s16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo
                            Image.asset(
                              AppImages.logo,
                              height: AppSizes.s75,
                              width: AppSizes.s75,
                            ),
                            gapH32,
                            // Login Page Headline
                            AutoSizeText(
                              AppStrings.loginTo.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            AutoSizeText(
                              AppStrings.yourAccount.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            gapH32,
                            // TOGGLE BUTTON TO TOGGLE BETWEEN (PHONE || EMAIL)
                            Consumer<AuthenticationViewModel>(
                              builder: (context, viewModel, child) {
                                return SwitchRow(
                                  isLoginPageStyle: true,
                                  value: viewModel.isPhoneLogin,
                                  onChanged: (newValue) =>
                                      viewModel.toggleLoginMethod(),
                                );
                              },
                            ),
                            gapH20,
                            // EMAIL OR PHONE FIELD
                            Consumer<AuthenticationViewModel>(
                              builder: (context, viewModel, child) {
                                return viewModel.isPhoneLogin
                                    ? PhoneNumberField(
                                        controller: viewModel.phoneController,
                                        countryCodeController:
                                            viewModel.countryCodeController,
                                      )
                                    : TextFormField(
                                        controller: viewModel.emailController,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.yourEmail.tr(),
                                        ),
                                        validator: (value) =>
                                            ValidationService.validateEmail(
                                                value),
                                      );
                              },
                            ),
                            gapH12,
                            // PASSWORD FIELD
                            TextFormField(
                              controller: viewModel.passwordController,
                              decoration: InputDecoration(
                                hintText: AppStrings.password.tr(),
                              ),
                              validator: (value) =>
                                  ValidationService.validatePassword(value),
                              obscureText: true,
                            ),
                            gapH12,
                            // FORGET PASSSORD BUTTON
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    await viewModel.showForgotPasswordModal(
                                      context: context,
                                    );
                                  },
                                  child: Text(AppStrings.forgetPassword.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ),
                              ],
                            ),
                            gapH16,
                            // LOGIN BUTTON
                            CustomElevatedButton(
                              title: AppStrings.login.tr(),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                await viewModel.login(context: context);
                              },
                              isPrimaryBackground: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // CREATE NEW ACCOUNT BUTTON (CONDITIONAL)
                  if ((Provider.of<AppConfigService>(context, listen: false)
                                  .getSettings(
                                      type: SettingsType.generalSettings)
                              as GeneralSettingsModel?)
                          ?.canNewRegister ??
                      true)
                    Positioned(
                      bottom: AppSizes.s40,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            width: AppSizes.s290,
                            title: AppStrings.createNewAccount.tr(),
                            isFuture: false,
                            onPressed: () => viewModel.showCreateAccountModal(
                                context: context),
                            buttonStyle: ElevatedButton.styleFrom(
                              fixedSize:
                                  const Size(double.infinity, AppSizes.s50),
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white, // Text color
                              disabledForegroundColor: Colors.transparent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.s28),
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            titleWidget: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.s16),
                              child: Text(
                                AppStrings.createNewAccount.tr(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  const LanguageDropdownButton()
                ],
              ),
            ),
          ),
        ));
  }
}
