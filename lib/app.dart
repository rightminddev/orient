import 'package:easy_localization/easy_localization.dart';
import 'constants/app_images.dart';
import 'general_services/app_theme.service.dart';
import 'platform/platform_is.dart';
import 'routing/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // precache spash screen image
    precacheImage(const AssetImage(AppImages.splashScreenBackground), context);
    final appGoRouter = goRouter(context);
    return MaterialApp.router(
      title: 'Orient',
      restorationScopeId: 'app',debugShowCheckedModeBanner: false,
      routerDelegate: appGoRouter.routerDelegate,
      routeInformationParser: appGoRouter.routeInformationParser,
      routeInformationProvider: appGoRouter.routeInformationProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner:false,
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
