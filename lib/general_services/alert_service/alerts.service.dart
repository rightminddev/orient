import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/validation_service.dart';
import '../../constants/app_sizes.dart';
import '../../platform/platform_is.dart';
import 'custom_alert.dart';

enum DialogAnimationTypes { none, feedIn, open, opacity }

abstract class AlertsService {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static success({
    required String title,
    required BuildContext context,
    required String message,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        _showSnackbar(
          title: title,
          context: context,
          message: message,
          type: AlertType.success,
        );
      }
    });
  }

  static warning({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        _showSnackbar(
          context: context,
          title: title,
          message: message,
          type: AlertType.warning,
        );
      }
    });
  }

  static info({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        _showSnackbar(
          context: context,
          title: title,
          message: message,
          color: Colors.grey,
          type: AlertType.warning,
        );
      }
    });
  }

  static error({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        _showSnackbar(
          context: context,
          title: title,
          message: message,
          type: AlertType.failure,
        );
      }
    });
  }

  static void _showSnackbar({
    required BuildContext context,
    required String title,
    required String message,
    required AlertType type,
    Color? color,
  }) {
    // Check if the context is mounted before proceeding
    if (!context.mounted) return;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      elevation: 0,
      padding: const EdgeInsets.only(top: AppSizes.s15, bottom: AppSizes.s5),
      backgroundColor: Colors.transparent,
      content: CustomAlert(
        title: title,
        message: message,
        contentType: type,
        color: color,
      ),
    );

    // Use the direct context instead of the global key
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showLoading(BuildContext context, {String title = ''}) async {
    var loadingWidget = Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shape: null,
      child: SizedBox(
        width: AppSizes.s200,
        height: AppSizes.s150,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
              const SizedBox(width: AppSizes.s15),
              Text(title.isEmpty ? 'Loading ...' : '$title, please wait')
            ],
          ),
        ),
      ),
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => loadingWidget,
    );
  }

  static Future<bool> confirmMessage(BuildContext context, String title, {
    String? message,
    form3Key,
    passwordForRemoveAccountController,
    String? imageAssert,
    DialogAnimationTypes animationType = DialogAnimationTypes.feedIn,
    Widget? icon,
    bool? viewPassword = false,
    bool? isArabic,
  }) async {
    var result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionBuilder: (dialogContext, a1, a2, _) => _dialogAnimated(
        animation: a1,
        type: animationType,
        body: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          child: SizedBox(
            width: PlatformIs.mobile ? AppSizes.s320 : AppSizes.s600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (imageAssert != null) const SizedBox(height: AppSizes.s60),
                if (imageAssert == null) const SizedBox(height: AppSizes.s50),
                imageAssert != null
                    ? Image.asset(imageAssert, width: AppSizes.s150, height: AppSizes.s90)
                    : icon != null
                    ? SizedBox(
                  width: AppSizes.s150,
                  height: AppSizes.s90,
                  child: icon,
                )
                    : const SizedBox(),
                if (imageAssert != null) const SizedBox(height: AppSizes.s25),
                Text(
                  title,
                  style: const TextStyle(fontSize: AppSizes.s25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.s20),
                message != null
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s30),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: AppSizes.s18, color: Colors.black45),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 4,
                  ),
                )
                    : const SizedBox(),
                const SizedBox(height: AppSizes.s10),
                if (viewPassword == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: form3Key,
                      child: TextFormField(
                        controller: passwordForRemoveAccountController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(hintText: AppStrings.password.tr()),
                        validator: (value) => ValidationService.validatePassword(value),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSizes.s10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: AppSizes.s100,
                      height: AppSizes.s60,
                      child: MaterialButton(
                        color: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        child: Text(AppStrings.yes.tr(), style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    ButtonTheme(
                      minWidth: AppSizes.s100,
                      height: AppSizes.s60,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        color: Colors.white,
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: Text(AppStrings.no.tr(), style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.s50),
              ],
            ),
          ),
        ),
      ),
    );

    return result ?? false;
  }

  static Widget _dialogAnimated({
    required Widget body,
    required DialogAnimationTypes type,
    required Animation<double> animation,
  }) {
    switch (type) {
      case DialogAnimationTypes.feedIn:
        return Column(children: <Widget>[
          Spacer(flex: (animation.value * 100).toInt() + 1),
          Opacity(opacity: animation.value, child: Transform.scale(scale: animation.value, child: body)),
          const Spacer(flex: 100),
        ]);
      case DialogAnimationTypes.opacity:
        return Column(children: <Widget>[
          const Spacer(),
          Opacity(opacity: animation.value, child: body),
          const Spacer(),
        ]);
      case DialogAnimationTypes.open:
        return Column(children: <Widget>[
          const Spacer(),
          Opacity(
            opacity: animation.value,
            child: SizeTransition(
              axisAlignment: 0.0,
              sizeFactor: animation,
              child: body,
            ),
          ),
          const Spacer(),
        ]);
      default:
        return SizedBox(child: body);
    }
  }
}