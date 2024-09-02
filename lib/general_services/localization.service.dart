import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_router.dart';

abstract class LocalizationService {
  static void setLocaleAndUpdateUrl(
      {required BuildContext context, required String newLangCode}) {
    // Set the locale
    final locale = Locale(newLangCode);
    context.setLocale(locale);
    context
        .goNamed(AppRoutes.splash.name, pathParameters: {'lang': newLangCode});
    // // Update the URL
    // final uri = GoRouterState.of(context).uri;
    // // Create a new URI with the updated language parameter
    // final updatedUri = uri.replace(queryParameters: {
    //   ...uri.queryParameters,
    //   'lang': newLangCode,
    // });

    // // Navigate to the updated URL
    // context.go(updatedUri.toString());
  }

  static bool isArabic({required BuildContext context}) =>
      context.locale.languageCode == 'ar';
}
