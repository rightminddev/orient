import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/app_config.service.dart';
import '../../../general_services/layout.service.dart';
import '../../../general_services/validation_service.dart';
import '../../../models/operation_result.model.dart';
import '../../../routing/app_router.dart';
import '../../../utils/modal_sheet_helper.dart';
import '../auth_services/account_verification.service.dart';
import '../auth_services/authentication.service.dart';
import '../auth_services/two_factor_authentication.service.dart';
import '../views/create_account_modal.dart';
import '../views/forget_password_modal.dart';
import '../views/widgets/verification_tile_widget.dart';

enum AuthStatus {
  active,
  blocked,
  deactivated,
  scheduledForDeletion,
  otpRequired,
  twoFactorAuthentication,
}

class AuthenticationViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isLoading2 = false;
  bool isSuccess = false;
  bool isSuccess2 = false;
  String? errorMessage;
  String? errorMessage2;
  bool isPhoneLogin = true;
  late AnimationController animationController;
  late Animation<double> animation;
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final countryCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isDisposed = false;
  bool _isDisposed2 = false;

  @override
  void dispose() {
    _isDisposed = true;
    _isDisposed2 = true;
    animationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }  bool status = false;
  postDeviceSys({context, fcmToken }){
    isLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_users/v1/device_sys",
        context : context,
        data: {
          "action" : "set",
          "key" : "notification_token",
          "value" : fcmToken
        }
    ).then((value){
      if (!_isDisposed) {
        isLoading = false;
        isSuccess = true;

        print(value.data);
        notifyListeners();
      }
    }).catchError((error){
      if (error is DioError) {
        if (!_isDisposed) {
          errorMessage = error.response?.data['message'] ?? 'Something went wrong';
        } else {
          errorMessage = error.toString();
        }
        isLoading = false;
        notifyListeners();
        }
    });
  }
  getDeviceSys({context, status}){
    isLoading2 = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_users/v1/device_sys",
        context : context,
        data: {
          "action" : "set",
          "key" : "notification_token_status",
          "value" : status
        }
    ).then((value){
      if (!_isDisposed2) {
        isLoading2 = false;
        status = (value.data['device']['notification_token_status'] == 0) ? false : true;
        print("PUT SUCCESS");
        CacheHelper.setBool( "status",  true);
        print(value.data);
        notifyListeners();
      }
    }).catchError((error){
      if (!_isDisposed2) {
        if (error is DioError) {
          errorMessage2 = error.response?.data['message'] ?? 'Something went wrong';
        } else {
          errorMessage2 = error.toString();
        }
        isLoading2 = false;
        notifyListeners();
      }
    });
  }

  void initializeAnimation(TickerProvider vsync) {
    animationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: vsync,
    )..repeat(reverse: true);
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
  }

  void toggleLoginMethod() {
    isPhoneLogin = !isPhoneLogin;
    notifyListeners();
  }

  Future<void> login({required BuildContext context}) async {
    print("request login /////1221");
    if (isPhoneLogin && phoneController.text.isEmpty) {
      AlertsService.warning(
          title: AppStrings.phoneNumber.tr(),
          context: context,
          message: AppStrings.phoneNumberIsRequired.tr());
      return;
    }
    print("request login /////13333333");
    if (formKey.currentState?.validate() == true) {
      print("request login /////44444444");
      final appConfigServiceProvider =
      Provider.of<AppConfigService>(context, listen: false);
      final completePhoneNumber = (countryCodeController.text.isEmpty
          ? '+02'
          : countryCodeController.text + phoneController.text)
          .trim();
      print("request login /////");
      OperationResult<Map<String, dynamic>> result =
      await AuthenticationService.login(
          context: context,
          username:
          isPhoneLogin ? completePhoneNumber : emailController.text,
          password: passwordController.text,
          deviceInformation:
          appConfigServiceProvider.deviceInformation.toMap());

      print("response login /////");
      if (result.success &&
          result.data != null &&
          (result.data?.isNotEmpty ?? false)) {
        await _handleLoginResponse(result: result.data!, context: context);
        await postDeviceSys(
            context: context,
            fcmToken:await FirebaseMessaging.instance.getToken()
        );
        await getDeviceSys(context: context, status: 1);
      } else {
        AlertsService.error(
            title: AppStrings.failed.tr(),
            context: context,
            message:
            result.message ?? AppStrings.failedLoginingPleaseTryAgain.tr());
      }
    } else {
      AlertsService.warning(
          title: AppStrings.formValidation.tr(),
          context: context,
          message: AppStrings.formIsInvalid.tr());
    }
  }

  Future<void> showForgotPasswordModal({required BuildContext context}) async {
    OperationResult<Map<String, dynamic>>? result =
    await ModalSheetHelper.showModalSheet(
        context: context,
        modalContent: ForgotPasswordModal(
          isPhoneLogin: isPhoneLogin,
        ),
        height: LayoutService.getHeight(context) * 0.45,
        title: AppStrings.forgetPassword.tr());
    if (result?.success ?? false) {
      // waiting till the modal closed smoothly then showing successfull slert
      Future.delayed(const Duration(seconds: 1));
      AlertsService.success(
          title: AppStrings.success.tr(),
          context: context,
          message:
          result?.message ?? AppStrings.passwordResetedPleaseLogin.tr());
    }
  }

  Future<void> showCreateAccountModal({required BuildContext context}) async {
    OperationResult<Map<String, dynamic>>? result =
    await ModalSheetHelper.showModalSheet(
        context: context,
        modalContent: const CreateAccountModal(),
        title: AppStrings.createNewAccount.tr(),
        height: MediaQuery.of(context).viewInsets.bottom > AppSizes.s32
            ? LayoutService.getHeight(context) * 0.9
            : LayoutService.getHeight(context) * 0.7);
    if (result?.success ?? false) {
      // waiting till the modal closed smoothly then showing successfull slert
      Future.delayed(const Duration(seconds: 1));
      AlertsService.success(
          title: AppStrings.success.tr(),
          context: context,
          message:
          result?.message ?? AppStrings.userRegisteredPleaseLogin.tr());
    }
  }

  Future<void> _show2FAVerificationPopup(
      {required BuildContext context,
        required Map<String, dynamic> methods,
        required String uuid}) async {
    PageController pageController = PageController();
    TextEditingController codeController = TextEditingController();
    final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
    String? choosenMethod;
    final appConfigServiceProvider =
    Provider.of<AppConfigService>(context, listen: false);

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(AppSizes.s16),
          titlePadding: const EdgeInsets.all(AppSizes.s16),
          contentPadding: const EdgeInsets.all(AppSizes.s12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.twoFactorVerification.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: AppSizes.s32,
                    color: Colors.red,
                  ))
            ],
          ),
          content: SizedBox(
            width: LayoutService.getWidth(context),
            height: AppSizes.s300,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // First Page: Method Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.pleaseSelectAMethod.tr(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                      textAlign: TextAlign.center,
                    ),
                    gapH16,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: methods.entries.map((m) {
                            final Map<String, dynamic> method = {
                              m.key: m.value
                            };
                            return VerificationTileWidget(
                              method: method,
                              onSelected: () async {
                                AlertsService.showLoading(context);
                                final result =
                                await TwoFactorAuthenticationService
                                    .send2FAVerificationCode(
                                    context: context,
                                    uuid: uuid,
                                    sendType: method.keys.first);
                                Navigator.pop(context);

                                if (result.success && method.isNotEmpty) {
                                  choosenMethod = method.keys.first;
                                  // Move to the next page
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Navigator.pop(context);
                                  AlertsService.error(
                                      title: AppStrings.failed.tr(),
                                      context: context,
                                      message: result.message ??
                                          AppStrings
                                              .failed2FAVerificationPleaseTryAgain
                                              .tr());
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                // Second Page: Code Input
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.twoFAVerificationCodeSent.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.s16),
                          textAlign: TextAlign.center,
                        ),
                        gapH12,
                        Text(
                          AppStrings.aVerificationCodeHasBeenSent.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Form(
                      key: codeFormKey,
                      child: TextFormField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterVerificationCode.tr(),
                        ),
                        validator: (value) =>
                            ValidationService.validateNumeric(value),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          title: AppStrings.verify.tr(),
                          onPressed: () async {
                            if (codeFormKey.currentState?.validate() == false) {
                              return;
                            }
                            final result = await TwoFactorAuthenticationService
                                .validate2FAVerificationCode(
                                uuid: uuid,
                                context: context,
                                code: codeController.text,
                                sendType: choosenMethod!,
                                deviceInformation: appConfigServiceProvider
                                    .deviceInformation
                                    .toMap());
                            if (result.success &&
                                (result.data?.isNotEmpty ?? false)) {
                              return await _handleLoginResponse(
                                  result: result.data!, context: context);
                            } else {
                              Navigator.of(context).pop(context);
                              AlertsService.error(
                                  title: AppStrings.failed.tr(),
                                  context: context,
                                  message: result.message ??
                                      AppStrings
                                          .failed2FAVerificationPleaseTryAgain
                                          .tr());

                              return;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.didnotReciveCode.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          child: Text(
                            AppStrings.resendCode.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            AlertsService.showLoading(context);
                            final result = await TwoFactorAuthenticationService
                                .send2FAVerificationCode(
                                context: context,
                                uuid: uuid,
                                sendType: choosenMethod ?? 'auth_app');
                            Navigator.pop(context);
                            if (!result.success) {
                              Navigator.pop(context);
                              AlertsService.error(
                                  title: AppStrings.failed.tr(),
                                  context: context,
                                  message: result.message ??
                                      AppStrings
                                          .failed2FAVerificationPleaseTryAgain
                                          .tr());
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAccountVerificationPopup(
      {required BuildContext context,
        required Map<String, dynamic> methods,
        required String uuid}) async {
    PageController pageController = PageController();
    TextEditingController codeController = TextEditingController();
    final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
    String? choosenMethod;
    final appConfigServiceProvider =
    Provider.of<AppConfigService>(context, listen: false);
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(AppSizes.s16),
          titlePadding: const EdgeInsets.all(AppSizes.s16),
          contentPadding: const EdgeInsets.all(AppSizes.s12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.accountVerification.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: AppSizes.s32,
                    color: Colors.red,
                  ))
            ],
          ),
          content: SizedBox(
            width: LayoutService.getWidth(context),
            height: AppSizes.s340,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // First Page: Method Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.pleaseSelectAMethod.tr(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: AppSizes.s17),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gapH16,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: methods.entries.map((m) {
                            final Map<String, dynamic> method = {
                              m.key: m.value
                            };
                            return VerificationTileWidget(
                              method: method,
                              onSelected: () async {
                                AlertsService.showLoading(context);
                                final result = await AccountVerificationService
                                    .accoutnVerification(
                                    uuid: uuid,
                                    method: method.keys.first,
                                    context: context);
                                Navigator.pop(context);
                                if (result.success && method.isNotEmpty) {
                                  choosenMethod = method.keys.first;
                                  // Move to the next page
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Navigator.pop(context);
                                  AlertsService.error(
                                      title: AppStrings.failed.tr(),
                                      context: context,
                                      message: result.message ??
                                          AppStrings
                                              .failedVerificationPleaseTryLater
                                              .tr());
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                // Second Page: Code Input
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.verificationCodeSent.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.s18,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        gapH16,
                        Text(
                          AppStrings.aVerificationCodeHasBeenSent.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Form(
                      key: codeFormKey,
                      child: TextFormField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: AppStrings.enterVerificationCode.tr(),
                        ),
                        validator: (value) =>
                            ValidationService.validateNumeric(value),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          isPrimaryBackground: false,
                          title: AppStrings.verify.tr(),
                          onPressed: () async {
                            if (codeFormKey.currentState?.validate() == false) {
                              return;
                            }
                            final result = await AccountVerificationService
                                .validateAccoutnVerificationCode(
                                uuid: uuid,
                                context: context,
                                code: codeController.text,
                                method: choosenMethod!,
                                deviceInformation: appConfigServiceProvider
                                    .deviceInformation
                                    .toMap());
                            if (result.success &&
                                (result.data?.isNotEmpty ?? false)) {
                              return await _handleLoginResponse(
                                  result: result.data!, context: context);
                            } else {
                              Navigator.of(context).pop(context);
                              AlertsService.error(
                                  title: AppStrings.failed.tr(),
                                  context: context,
                                  message: result.message ??
                                      AppStrings
                                          .failedVerificationPleaseTryLater
                                          .tr());
                              return;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.didnotReciveCode.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          child: Text(
                            AppStrings.resendCode.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            AlertsService.showLoading(context);
                            final result = await AccountVerificationService
                                .accoutnVerification(
                                uuid: uuid,
                                method: choosenMethod ?? 'email',
                                context: context);
                            Navigator.pop(context);
                            if (!result.success) {
                              Navigator.pop(context);
                              AlertsService.error(
                                  title: AppStrings.failed.tr(),
                                  context: context,
                                  message: result.message ??
                                      AppStrings
                                          .failedVerificationPleaseTryLater
                                          .tr());
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleLoginResponse(
      {required Map<String, dynamic> result,
        required BuildContext context}) async {
    final appConfigServiceProvider =
    Provider.of<AppConfigService>(context, listen: false);

    if (result['token'] != null &&
        (((result['token'] as String?)?.isNotEmpty) ?? false)) {
      print(result['token']);
      return await appConfigServiceProvider.setAuthenticationStatusWithToken(
          isLogin: true, token: result['token']);
    }
    //check on Account Activation
    if (result['status'] == true &&
        result['require_activation'] == true &&
        (result['activation_uuid'] != null &&
            ((result['activation_uuid'] as String?)?.isNotEmpty ?? false))) {
      // check about activation methods if exsits , then i will show popup that containing verification options to let user choose the method then complete verification process
      // if verification methods not exists , then i will show error message and return
      if (result['activation_methods'] != null &&
          ((result['activation_methods'] as Map).keys).isNotEmpty) {
        // show verification options popup here
        return await _showAccountVerificationPopup(
            uuid: result['activation_uuid'],
            context: context,
            methods: result['activation_methods']);
      } else {
        AlertsService.error(
          context: context,
          message: AppStrings.failedVerifingThisAccountPleaseTryAgain.tr(),
          title: AppStrings.failed.tr(),
        );
        return;
      }
    }
    // applying 2FA autnetication
    if (result['status'] == true &&
        result['login_status'] == 'tfa' &&
        result['tfa'] == true &&
        (result['tfa_uuid'] != null && result['tfa_uuid'] != '') &&
        (result['tfa_methods'] != null && result['tfa_methods'] != {})) {
      if (result['tfa_methods'] != null &&
          ((result['tfa_methods'] as Map).keys).isNotEmpty) {
        // show verification options popup here
        return await _show2FAVerificationPopup(
            uuid: result['tfa_uuid'],
            context: context,
            methods: result['tfa_methods']);
      } else {
        AlertsService.error(
          context: context,
          message: AppStrings.failed2FAVerificationPleaseTryAgain.tr(),
          title: AppStrings.failed.tr(),
        );
        return;
      }
    }
    // Check on other login status
    AuthStatus authStatus =
    _getAuthStatusFromString(status: result['login_status']);
    switch (authStatus) {
      case AuthStatus.active:
        appConfigServiceProvider.setAuthenticationStatusWithToken(
            isLogin: true, token: result['token']);
        context.goNamed(AppRoutes.eCommerceHomeScreen.name);
        //context.goNamed(AppRoutes.addStore.name);
        return;
      case AuthStatus.deactivated:
        AlertsService.info(
          context: context,
          message: AppStrings.thisAccountHasBeenDeactivated.tr(),
          title: AppStrings.informational.tr(),
        );
        return;
      case AuthStatus.blocked:
        AlertsService.warning(
          context: context,
          message: AppStrings.thisAccountHasBeenBlocked.tr(),
          title: AppStrings.warning.tr(),
        );
        return;
      case AuthStatus.scheduledForDeletion:
        AlertsService.warning(
          context: context,
          message: AppStrings.thisAccountHasBeenScheduledForDeletion.tr(),
          title: AppStrings.warning.tr(),
        );
        return;
      default:
        return AlertsService.error(
          context: context,
          message: AppStrings.failedLoginingPleaseTryAgain.tr(),
          title: AppStrings.failed.tr(),
        );
    }
  }

  AuthStatus _getAuthStatusFromString({required String status}) {
    AuthStatus authStatus;
    switch (status) {
      case 'active':
        authStatus = AuthStatus.active;
        break;
      case 'blocked':
        authStatus = AuthStatus.blocked;
        break;
      case 'deactivated':
        authStatus = AuthStatus.deactivated;
        break;
      case 'scheduled_for_deletion':
        authStatus = AuthStatus.scheduledForDeletion;
        break;
      case 'otp_required':
        authStatus = AuthStatus.otpRequired;
        break;
      case 'two_factor_authentication':
        authStatus = AuthStatus.twoFactorAuthentication;
        break;
      default:
        authStatus = AuthStatus.active;
    }
    return authStatus;
  }
}