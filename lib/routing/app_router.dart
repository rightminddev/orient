import 'package:easy_localization/easy_localization.dart';
import 'package:orient/modules/eCommerce_more_screen.dart';
import 'package:orient/modules/ecommerce/checkout/checkout_screen.dart';
import 'package:orient/modules/ecommerce/search/search_screen.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/modules/ecommerce/test_screen.dart';
import '../general_services/app_config.service.dart';
import '../models/request.model.dart';
import '../modules/authentication/views/login_screen.dart';
import '../modules/ecommerce/cart/cart_screen.dart';
import '../modules/ecommerce/home/home_screen.dart';
import '../modules/ecommerce/main_screen/main_screen.dart';
import '../modules/general/views/comapny_structure_info_screen.dart';
import '../modules/fingerprint/views/fingerprint_screen.dart';
import '../modules/general/views/company_structure_tree_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/main_screen/views/main_screen.dart';
import '../modules/notifications/views/notifications_screen.dart';
import '../modules/offline/views/offline_screen.dart';
import '../modules/payrolls/models/payroll.model.dart';
import '../modules/payrolls/views/payroll_details_screen.dart';
import '../modules/payrolls/views/payrolls_list_screen.dart';
import '../modules/personal_profile/views/personal_profile_screen.dart';
import '../modules/profiles/models/employee_profile.model.dart';
import '../modules/profiles/views/employee_details_screen.dart';
import '../modules/profiles/views/employees_list_screen.dart';
import '../modules/requests/views/add_request_screen.dart';
import '../modules/requests/views/request_details_screen.dart';
import '../modules/requests/views/requests_screen.dart';
import '../modules/requests/views/requests_by_id_screen.dart';
import '../modules/rewards_and_penalties/views/add_rewards_and_penalties_screen.dart';
import '../modules/rewards_and_penalties/views/rewards_and_penalties_screen.dart';
import '../modules/splash_and_onboarding/views/onboarding_screen.dart';
import '../modules/splash_and_onboarding/views/splash_screen.dart';
import '../routing/app_router_transitions.dart';
import '../routing/not_found/not_found_screen.dart';
import '../services/requests.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../modules/requests/views/requests_calendar_screen.dart';

enum AppRoutes {
  home,
  splash,
  onboarding,
  login,
  offlineScreen,
  qrcodeScreen,
  fingerprint,
  requests,
  notifications,
  more,
  requestsById,
  requestDetails,
  addRequest,
  requestsCalendar,
  employeesList,
  employeeDetails,
  companyTree,
  personalProfile,
  payrollsList,
  payrollDetails,
  rewardsAndPenalties,
  addRewardsAndPenalties,
  eCommerceMainScreen,
  eCommerceHomeScreen,
  eCommerceTestScreen,
  eCommerceMoreScreen,
  ecommerceSingleProductDetailScreen,
  eCommerceSearchScreen,
  eCommerceCheckoutScreen,
  eCommerceCheckoutScreenView,
  eCommerceShoppingCart,
  eCommerceShoppingCartView,
}

const TestVSync ticker = TestVSync();

class TestVSync implements TickerProvider {
  const TestVSync();
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

enum NavbarPages { home, requests, fingerprint, notifications, more }
enum EcommerceNavbarPages { eCommerceHomeScreen,  ecommerceTestScreen, eCommerceShoppingCart, eCommerceSearchScreen, eCommerceMoreScreen }

NavbarPages getNavbarPage({required String currentLocationRoute}) {
  if (currentLocationRoute.contains('requests')) {
    return NavbarPages.requests;
  }
  if (currentLocationRoute.contains('fingerprint')) {
    return NavbarPages.fingerprint;
  }
  if (currentLocationRoute.contains('notifications')) {
    return NavbarPages.notifications;
  }
  if (currentLocationRoute.contains('more')) {
    return NavbarPages.more;
  }
  return NavbarPages.home;
}
EcommerceNavbarPages getEcommerceNavbarPage({required String currentLocationRoute}) {
  if (currentLocationRoute.contains('home')) {
    return EcommerceNavbarPages.eCommerceHomeScreen;
  }
  if (currentLocationRoute.contains('search')) {
    return EcommerceNavbarPages.eCommerceSearchScreen;
  }
  if (currentLocationRoute.contains('test')) {
    return EcommerceNavbarPages.ecommerceTestScreen;
  }
  if (currentLocationRoute.contains('cart')) {
    return EcommerceNavbarPages.eCommerceShoppingCart;
  }
  if (currentLocationRoute.contains('mores')) {
    return EcommerceNavbarPages.eCommerceMoreScreen;
  }
  return EcommerceNavbarPages.eCommerceHomeScreen;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter goRouter(BuildContext context) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/${context.locale.languageCode}/splash-screen',
  refreshListenable: Provider.of<AppConfigService>(context),
  redirect: (context, state) {
    final appConfigServiceProvider =
    Provider.of<AppConfigService>(context, listen: false);
    final isLoggedIn = appConfigServiceProvider.isLogin &&
        appConfigServiceProvider.token.isNotEmpty;
    final lang = state.pathParameters['lang'] ?? 'en';
    context.setLocale(Locale(lang));
    if (isLoggedIn && (state.fullPath?.contains('login') ?? false)) {
      return '/$lang';
    }
    // User not logged in and the current screen not (splash - onboarding - offline)
    if (isLoggedIn == false &&
        (state.fullPath?.contains('splash') == false &&
            state.fullPath?.contains('offline') == false &&
            state.fullPath?.contains('onboarding') == false)) {
      return '/$lang/login-screen';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/:lang/splash-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
        path: '/:lang/onboarding-screen',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoutes.onboarding.name,
        pageBuilder: (context, state) {
          final animationController = AnimationController(
            vsync: ticker,
          );
          // Make sure to dispose the controller after the transition is complete
          animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              animationController.dispose();
            }
          });
          return AppRouterTransitions.slideTransition(
            key: state.pageKey,
            child: const OnBoardingScreen(),
            animation: animationController,
            begin: const Offset(1.0, 0.0),
          );
        }),
    GoRoute(
        path: '/:lang/login-screen',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) {
          final animationController = AnimationController(
            vsync: ticker,
          );
          // Make sure to dispose the controller after the transition is complete
          animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              animationController.dispose();
            }
          });
          return AppRouterTransitions.slideTransition(
            key: state.pageKey,
            child: const LoginScreen(),
            animation: animationController,
            begin: const Offset(1.0, 0.0),
          );
        }),
    GoRoute(
      path: '/:lang/offline-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.offlineScreen.name,
      builder: (context, state) => const OfflineScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ECommerceMainScreen(
       // key: UniqueKey(),
        ecommerceNavbarPages: state.fullPath == null
            ? EcommerceNavbarPages.eCommerceHomeScreen
            : getEcommerceNavbarPage(currentLocationRoute: state.fullPath!),
        child: child,
      ),
      routes: [
        GoRoute(
            path: '/:lang',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceHomeScreen.name,
            pageBuilder: (context, state) {
              Offset? begin = state.extra as Offset?;
              final lang = state.uri.queryParameters['lang'];
              if (lang != null) {
                final locale = Locale(lang);
                context.setLocale(locale);
              }
              final animationController = AnimationController(
                vsync: ticker,
              );
              // Make sure to dispose the controller after the transition is complete
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child: ECommerceHomeScreen(),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
            routes: [
              GoRoute(
                path: 'single-product',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.ecommerceSingleProductDetailScreen.name,
                pageBuilder: (context, state) {
                 // Offset? begin = state.extra as Offset?;
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  // Make sure to dispose the controller after the transition is complete
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: EcommerceSingleProductDetailScreen(),
                    animation: animationController,
                    begin:  const Offset(1.0, 0.0),
                  );
                },

              ),
              GoRoute(
                  path: 'shopping-view',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: AppRoutes.eCommerceShoppingCartView.name,
                  pageBuilder: (context, state) {
                    Offset? begin = state.extra as Offset?;
                    final lang = state.uri.queryParameters['lang'];
                    if (lang != null) {
                      final locale = Locale(lang);
                      context.setLocale(locale);
                    }
                    final animationController = AnimationController(
                      vsync: ticker,
                    );
                    // Make sure to dispose the controller after the transition is complete
                    animationController.addStatusListener((status) {
                      if (status == AnimationStatus.completed ||
                          status == AnimationStatus.dismissed) {
                        animationController.dispose();
                      }
                    });
                    return AppRouterTransitions.slideTransition(
                      key: state.pageKey,
                      child: ECommerceShoppingCart(mainScreen: false,),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'checkout',
                      parentNavigatorKey: _rootNavigatorKey,
                      name: AppRoutes.eCommerceCheckoutScreenView.name,
                      pageBuilder: (context, state) {
                        Offset? begin = state.extra as Offset?;
                        final lang = state.uri.queryParameters['lang'];
                        if (lang != null) {
                          final locale = Locale(lang);
                          context.setLocale(locale);
                        }
                        final animationController = AnimationController(
                          vsync: ticker,
                        );
                        // Make sure to dispose the controller after the transition is complete
                        animationController.addStatusListener((status) {
                          if (status == AnimationStatus.completed ||
                              status == AnimationStatus.dismissed) {
                            animationController.dispose();
                          }
                        });
                        return AppRouterTransitions.slideTransition(
                          key: state.pageKey,
                          child: ECommerceCheckoutScreen(),
                          animation: animationController,
                          begin: begin ?? const Offset(1.0, 0.0),
                        );
                      },
                    ),
                  ]
              ),
            ]),
        GoRoute(
            path: '/:lang/test',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceTestScreen.name,
            pageBuilder: (context, state) {
             // Offset? begin = state.extra as Offset?;
              final lang = state.uri.queryParameters['lang'];
              if (lang != null) {
                final locale = Locale(lang);
                context.setLocale(locale);
              }
              final animationController = AnimationController(
                vsync: ticker,
              );
              // Make sure to dispose the controller after the transition is complete
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child: const TestScreen(),
                animation: animationController,
                begin:  const Offset(1.0, 0.0),
              );
            },
            ),
        GoRoute(
            path: '/:lang/cart',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceShoppingCart.name,
            pageBuilder: (context, state) {
              Offset? begin = state.extra as Offset?;
              final lang = state.uri.queryParameters['lang'];
              if (lang != null) {
                final locale = Locale(lang);
                context.setLocale(locale);
              }
              final animationController = AnimationController(
                vsync: ticker,
              );
              // Make sure to dispose the controller after the transition is complete
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child: ECommerceShoppingCart(mainScreen: true,),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
          routes: [
            GoRoute(
              path: 'checkout',
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRoutes.eCommerceCheckoutScreen.name,
              pageBuilder: (context, state) {
                Offset? begin = state.extra as Offset?;
                final lang = state.uri.queryParameters['lang'];
                if (lang != null) {
                  final locale = Locale(lang);
                  context.setLocale(locale);
                }
                final animationController = AnimationController(
                  vsync: ticker,
                );
                // Make sure to dispose the controller after the transition is complete
                animationController.addStatusListener((status) {
                  if (status == AnimationStatus.completed ||
                      status == AnimationStatus.dismissed) {
                    animationController.dispose();
                  }
                });
                return AppRouterTransitions.slideTransition(
                  key: state.pageKey,
                  child: ECommerceCheckoutScreen(),
                  animation: animationController,
                  begin: begin ?? const Offset(1.0, 0.0),
                );
              },
            ),
          ]
            ),
        GoRoute(
            path: '/:lang/search',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceSearchScreen.name,
            pageBuilder: (context, state) {
              Offset? begin = state.extra as Offset?;
              final lang = state.uri.queryParameters['lang'];
              if (lang != null) {
                final locale = Locale(lang);
                context.setLocale(locale);
              }
              final animationController = AnimationController(
                vsync: ticker,
              );
              // Make sure to dispose the controller after the transition is complete
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child:const ECommerceSearchScreen(),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
            ),
        GoRoute(
            path: '/:lang/mores',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceMoreScreen.name,
            pageBuilder: (context, state) {
              Offset? begin = state.extra as Offset?;
              final animationController = AnimationController(
                vsync: ticker,
              );
              // Make sure to dispose the controller after the transition is complete
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child: EcommerceMoreScreen(),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const NotFoundScreen(),
);