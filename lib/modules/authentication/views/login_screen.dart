import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/shared_more_screen/lang_setting/logic/lang_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/media_query_values.dart';
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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  late AuthenticationViewModel viewModel;
  bool _obscureText = true;
  final ValueNotifier<bool> isLoginBySocial = ValueNotifier<bool>(false);
  late final AppConfigService appConfigServiceProvider;
  AppLifecycleState _appLifecycleState = AppLifecycleState.inactive;
  GeneralSettingsModel? generalSettings;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        log("app in resumed");
        if (_appLifecycleState == AppLifecycleState.inactive &&
            isLoginBySocial.value == true) {
          // TODO: Call an api here
          //getDeviceToken

          viewModel.getDeviceToken(context: context);
          isLoginBySocial.value = false;
          log('AFTER LOGIN');
        } else {
          _appLifecycleState = AppLifecycleState.resumed;
        }
        break;
      case AppLifecycleState.inactive:
        log("app in inactive");
        _appLifecycleState = AppLifecycleState.inactive;
        break;
      case AppLifecycleState.paused:
        log("app in paused");
        _appLifecycleState = AppLifecycleState.paused;
        break;
      case AppLifecycleState.detached:
        log("app in detached");
        _appLifecycleState = AppLifecycleState.detached;
        break;
      case AppLifecycleState.hidden:
        log("app in hidden");
        _appLifecycleState = AppLifecycleState.hidden;
        break;
    }
  }
  @override
  void initState() {
    super.initState();
    viewModel = AuthenticationViewModel();
    viewModel.initializeAnimation(this);
    WidgetsBinding.instance.addObserver(this);
    print("ROLE FROM CACHE IS ---> ${CacheHelper.getString('role')}");

  }
  @override
  void dispose() {
    isLoginBySocial.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var gCache;
    final jsonString = CacheHelper.getString("USG");
    if (jsonString != null) {
      gCache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
      print("S2 IS --> $gCache");
    }
    return ChangeNotifierProvider<AuthenticationViewModel>(
        create: (context) => viewModel,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
            child: SingleChildScrollView(
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
                            alignment: Alignment(
                                (viewModel.animation.value * 2) - 1, 0),
                            child: Image.asset(
                              AppImages.splashScreenBackground,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    const OverlayGradientWidget(),
                    Center  (
                      child: Form(
                        key: viewModel.formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.s16),
                          child: SizedBox(
                            width: LayoutService.getWidth(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back, color: Color(0xffFFFFFF),),
                                    SizedBox(width: 5,),
                                    GestureDetector(
                                      onTap: (){
                                        context.goNamed(
                                          AppRoutes.loginAdmin.name,
                                          pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "true"},
                                        );
                                      },
                                      child: Text(AppStrings.backToSelectAccountType.tr(), style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w400
                                      ),),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Image.asset(
                                  AppImages.logo,
                                  width: AppSizes.s200,
                                  height: AppSizes.s70,
                                  fit: BoxFit.contain,
                                ),
                                gapH32,
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
                                Consumer<AuthenticationViewModel>(
                                  builder: (context, viewModel, child) {
                                    return viewModel.isPhoneLogin
                                        ? PhoneNumberField(
                                            controller: viewModel.phoneController,
                                            countryCodeController: viewModel.countryCodeController,
                                          )
                                        : TextFormField(
                                            controller:
                                                viewModel.emailController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppStrings.yourEmail.tr().toUpperCase(),
                                            ),
                                            // validator: (value) =>
                                            //     ValidationService.validateEmail(
                                            //         value),
                                          );
                                  },
                                ),
                                gapH12,
                                // PASSWORD FIELD
                                TextFormField(
                                  controller: viewModel.passwordController,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.password.tr().toUpperCase(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) =>
                                      ValidationService.validatePassword(value, login: true),
                                  obscureText: _obscureText,
                                ),
                                gapH12,
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
                                      child: Text(
                                          AppStrings.forgetPassword.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium),
                                    ),
                                  ],
                                ),
                                gapH16,
                                // LOGIN BUTTON
                                ChangeNotifierProvider(
                                  create: (context) => LangControllerProvider(),
                                child: Consumer<LangControllerProvider>(builder: (context, value, child){
                                  return CustomElevatedButton(
                                    title: AppStrings.login.tr(),
                                    onPressed: () async {
                                      // if(LocalizationService.isArabic(context: context)){
                                      //   await value.setDeviceSysLang(
                                      //       state:  "ar",
                                      //       context: context,
                                      //       notiToken:await FirebaseMessaging.instance.getToken()
                                      //   );
                                      // }else{
                                      //   await value.setDeviceSysLang(
                                      //       state:  "en",
                                      //       context: context,
                                      //       notiToken:await FirebaseMessaging.instance.getToken()
                                      //   );
                                      // }
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      await viewModel.login(context: context);
                                    },
                                    isPrimaryBackground: false,
                                  );
                                },),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if ((gCache['login_types'] ?? [])
                                        .contains('social_google'))
                                      defaultCircularSocial(
                                        context: context,
                                        src: AppIcons.google,
                                        onTap: () async {
                                          isLoginBySocial.value = true;
                                          final deviceUniqueId =
                                          Provider.of<AppConfigService>(context, listen: false).deviceInformation.deviceUniqueId;
                                          final url =
                                              'https://backend.orient-paints.com/auth/socialite/google/login?redirect_url=https://backend.orient-paints.com/front-end/social_login&device_unique_id=$deviceUniqueId';
                                          await viewModel.loginWithSocial(context, url);
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                    if ((gCache['login_types'] ?? [])
                                        .contains('social_facebook'))
                                      defaultCircularSocial(
                                        context: context,
                                        src: AppIcons.facebookColored,
                                        onTap: () async {
                                          isLoginBySocial.value = true;
                                          final deviceUniqueId =
                                              Provider.of<AppConfigService>(context, listen: false).deviceInformation.deviceUniqueId;
                                          final url =
                                              'https://backend.orient-paints.com/auth/socialite/facebook/login?redirect_url=https://backend.orient-paints.com/front-end/social_login&device_unique_id=$deviceUniqueId';

                                          await viewModel.loginWithSocial(context, url);
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                    if ((gCache['login_types'] ?? [])
                                        .contains('social_linkedin-openid'))
                                      defaultCircularSocial(
                                        context: context,
                                        src: AppIcons.linkedInColored,
                                        onTap: () async {
                                          isLoginBySocial.value = true;
                                          final deviceUniqueId =
                                              Provider.of<AppConfigService>(context, listen: false).deviceInformation.deviceUniqueId;
                                          final url =
                                              'https://backend.orient-paints.com/auth/socialite/linkedin-openid/login?redirect_url=https://backend.orient-paints.com/front-end/social_login&device_unique_id=$deviceUniqueId';
                                          await viewModel.loginWithSocial(context, url);
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                      Positioned(
                        bottom: AppSizes.s10,
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
          ),
        ));
  }
}
Widget defaultCircularSocial({context, onTap, src, color}) => GestureDetector(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.all(5),
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xffFFFFFF),
    ),
    child: SvgPicture.asset(src),
  ),
);
