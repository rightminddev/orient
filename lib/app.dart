import 'package:easy_localization/easy_localization.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'constants/app_images.dart';
import 'general_services/app_theme.service.dart';
import 'package:orient/routing/app_router.dart';
import 'platform/platform_is.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if(CacheHelper.getString("lang") == null){
      CacheHelper.setString(key: "lang", value: context.locale.languageCode);
    }
    // precache spash screen image
    precacheImage(const AssetImage(AppImages.splashScreenBackground), context);
    final appGoRouter = goRouter(context);
    return
      MaterialApp.router(
      title: 'Orient',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      routerDelegate: appGoRouter.routerDelegate,
      routeInformationParser: appGoRouter.routeInformationParser,
      routeInformationProvider: appGoRouter.routeInformationProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: ThemeMode.light,
      theme: AppThemeService.getTheme(isDark: false, context: context),
      darkTheme: AppThemeService.getTheme(isDark: true, context: context),
      scrollBehavior: PlatformIs.web ? AppScrollBehavior() : null,
    );

  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.trackpad,
      };
}
