import 'package:easy_localization/easy_localization.dart';
import 'package:orient/modules/painters/merchants/views/merchants_home_screen.dart';
import 'package:orient/modules/painters/teams/views/teams_screen.dart';
import 'constants/app_images.dart';
import 'general_services/app_theme.service.dart';
import 'modules/components/subviews/button_screen.dart';
import 'modules/components/subviews/comment_screen.dart';
import 'modules/components/subviews/image_with_title_screen.dart';
import 'modules/components/subviews/order_screen.dart';
import 'package:orient/modules/ecommerce/cart/cart_screen.dart';
import 'package:orient/modules/ecommerce/checkout/checkout_screen.dart';
import 'package:orient/modules/ecommerce/home/home_screen.dart';
import 'package:orient/modules/ecommerce/search/search_screen.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/modules/main_screen/views/main_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'constants/app_images.dart';
import 'general_services/app_theme.service.dart';
import 'modules/ecommerce/main_screen/main_screen.dart';
import 'platform/platform_is.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // precache spash screen image
    precacheImage(const AssetImage(AppImages.splashScreenBackground), context);
    final appGoRouter = goRouter(context);
    return MaterialApp
    .router
    (
      title: 'Orient',
      restorationScopeId: 'app',
      // home: TeamsScreen(),
      routerDelegate: appGoRouter.routerDelegate,
      routeInformationParser: appGoRouter.routeInformationParser,
      routeInformationProvider: appGoRouter.routeInformationProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: const Locale("en"), //context.locale,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemeService.getTheme(isDark: false, context: context),
      darkTheme: AppThemeService.getTheme(isDark: true, context: context),
      scrollBehavior: PlatformIs.web ? AppScrollBehavior() : null,
    );

    // return MaterialApp(
    //   title: 'Orient',
    //   restorationScopeId: 'app',
    //   routes: {
    //     '/buttons': (context) => const ButtonsScreen(),
    //     '/image_with_title': (context) => const ImageWithTitleScreen(),
    //     '/comment_widget': (context) => const CommentScreen(),
    //     '/order_widget': (context) => const OrderScreen(),
    //   },
    //   supportedLocales: const [
    //     Locale('en', 'US'),
    //     Locale('ar', 'EG'),
    //   ],
    //   themeMode: ThemeMode.light,
    //   theme: AppThemeService.getTheme(isDark: false, context: context),
    //   darkTheme: AppThemeService.getTheme(isDark: true, context: context),
    //   scrollBehavior: AppScrollBehavior(),
    //   home: const ComponenetsScreen(),
    // );
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
