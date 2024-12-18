import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:orient/merchant/main/subviews/merchant_home_screen.dart';
import 'package:orient/merchant/main/subviews/merchant_stores_screen.dart';
import 'package:orient/merchant/main/views/merchant_main_screen.dart';
import 'package:orient/merchant/orders/views/my_orders_screen.dart';
import 'package:orient/merchant/orders/views/order_details_screen.dart';
import 'package:orient/merchant/stores/views/available_products_screen.dart';
import 'package:orient/merchant/stores/views/create_edit_store_screen.dart';
import 'package:orient/merchant/stores/views/my_stores_actions_screen.dart';
import 'package:orient/models/stores/store_model.dart';
import 'package:orient/modules/authentication/views/admin_login_screen.dart';
import 'package:orient/modules/eCommerce_more_screen.dart';
import 'package:orient/modules/ecommerce/blog/view/blog_details_screen.dart';
import 'package:orient/modules/ecommerce/blog/view/blog_screen.dart';
import 'package:orient/modules/ecommerce/bookmark/view/bookmark_screen.dart';
import 'package:orient/modules/ecommerce/checkout/checkout_screen.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_payment_webview.dart';
import 'package:orient/modules/ecommerce/home/color_trend/color_trend_screen.dart';
import 'package:orient/modules/ecommerce/home/get_inspired_screen.dart';
import 'package:orient/modules/ecommerce/home/inspired/inspired_screen.dart';
import 'package:orient/modules/ecommerce/myorder/ecommerce_order_details_screen.dart';
import 'package:orient/modules/ecommerce/myorder/ecommerce_order_screen.dart';
import 'package:orient/modules/ecommerce/search/search_screen.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/modules/ecommerce/test_screen.dart';
import 'package:orient/modules/settings_page/setting_page_two.dart';
import 'package:orient/modules/settings_page/settings_page.dart';
import 'package:orient/modules/shared_more_screen/aboutus/view/aboutus_screen.dart';
import 'package:orient/modules/shared_more_screen/branches/view/branches_screen.dart';
import 'package:orient/modules/shared_more_screen/contactus/view/contact_screen.dart';
import 'package:orient/modules/shared_more_screen/faq/view/faq_screen.dart';
import 'package:orient/modules/shared_more_screen/lang_setting/view/lang_setting_screen.dart';
import 'package:orient/modules/shared_more_screen/personal_profile/views/personal_profile_screen.dart';
import 'package:orient/modules/shared_more_screen/promocode/view/promocode_screen.dart';
import 'package:orient/modules/shared_more_screen/shipping_address/view/shipping_address_screen.dart';
import 'package:orient/modules/shared_more_screen/update_password/view/update_password_screen.dart';
import 'package:orient/painter/group_page/groups_page.dart';
import 'package:orient/modules/notification/view/notification_details_screen.dart';
import 'package:orient/modules/notification/view/notification_screen.dart';
import 'package:orient/painter/layout_page/layout_page.dart';
import 'package:orient/painter/points/points_screen.dart';
import 'package:orient/painter/post/add_post_screen.dart';
import 'package:orient/painter/post/post_details_screen.dart';
import 'package:orient/painter/teams/views/create_team_screen.dart';
import 'package:orient/painter/teams/views/team_members_screen.dart';
import 'package:orient/painter/teams/views/teams_screen.dart';
import '../general_services/app_config.service.dart';
import '../modules/authentication/views/login_screen.dart';
import '../modules/ecommerce/cart/cart_screen.dart';
import '../modules/ecommerce/home/home_screen.dart';
import '../modules/ecommerce/main_screen/main_screen.dart';
import '../modules/offline/views/offline_screen.dart';
import '../modules/splash_and_onboarding/views/onboarding_screen.dart';
import '../modules/splash_and_onboarding/views/splash_screen.dart';
import '../painter/home_screen/views/painter_main_screen.dart';
import '../painter/teams/views/rated_team_screen.dart';
import '../routing/app_router_transitions.dart';
import '../routing/not_found/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum AppRoutes {
  home,
  addStore,
  langSettingScreen,
  personalInfoScreen,
  promoCodeScreen,
  faqScreen,
  contactUs,
  updatePassword,
  aboutusScreen,
  shippingAddress,
  splash,
  notification,
  blog,
  notificationDetails,
  blogDetails,
  onboarding,
  login,
  loginAdmin,
  storeActions,
  orderDetails,
  storeAvailableProducts,
  offlineScreen,
  qrcodeScreen,
  fingerprint,
  requests,
  myOrderScreen,
  notifications,
  more,
  branchScreen,
  bookMark,
  requestsById,
  requestDetails,
  addRequest,
  stores,
  editStore,
  requestsCalendar,
  employeesList,
  employeeDetails,
  companyTree,
  personalProfile,
  payrollsList,
  payrollDetails,
  rewardsAndPenalties,
  addRewardsAndPenalties,
  merchantHomeScreen,
  merchantNotifications,
  merchantMore,
  merchantStoresScreen,
  merchantViewStoresScreen,
  merchantStoreOrders,
  eCommerceMainScreen,
  eCommerceHomeScreen,
  eCommerceTestScreen,
  eCommerceMoreScreen,
  ecommerceSingleProductDetailScreen,
  eCommerceSearchScreen,
  eCommerceSearchScreenView,
  eCommerceCheckoutScreen,
  eCommerceCheckoutScreenView,
  eCommerceShoppingCart,
  eCommerceShoppingCartView,
  eCommerceColorTrendScreen,
  eCommerceGetInspiredScreen,
  eCommerceWebViewScreen,
  eCommerceMyOrderScreen,
  eCommerceMyOrderDetailsScreen,
  painterLayOutScreen,
  painterHomeScreen,
  painterMyGroupsScreen,
  painterViewMyGroupsScreen,
  painterTeamsScreen,
  painterViewTeamsScreen,
  painterCreateTeamsScreen,
  painterMemberTeamsScreen,
  painterRatedTeamsScreen,
  painterPointsScreen,
  painterPointsViewScreen,
  painterProfileScreen,
  painterSingleListDetailsScreen,
  postDetailsScreen,
  addPostScreen,
  postDetailsTwoScreen,
}

const TestVSync ticker = TestVSync();

class TestVSync implements TickerProvider {
  const TestVSync();
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

enum NavbarPages { home, requests, fingerprint, notifications, more }

enum EcommerceNavbarPages {
  eCommerceHomeScreen,
  ecommerceTestScreen,
  eCommerceMyOrderScreen,
  eCommerceSearchScreen,
  eCommerceMoreScreen
}

enum MerchantNavbarPages {
  merchantHomeScreen,
  merchantStoresScreen,
  merchantNotifications,
  merchantMore
}

enum PainterNavbarPages {
  painterHomeScreen,
  painterMyGroupsScreen,
  painterTeamsScreen,
  painterPointsScreen,
  painterProfileScreen
}

PainterNavbarPages getPainterNavbarPage(
    {required String currentLocationRoute}) {
  if (currentLocationRoute.contains('home')) {
    return PainterNavbarPages.painterHomeScreen;
  }
  if (currentLocationRoute.contains('groups')) {
    return PainterNavbarPages.painterMyGroupsScreen;
  }
  if (currentLocationRoute.contains('teams')) {
    return PainterNavbarPages.painterTeamsScreen;
  }
  if (currentLocationRoute.contains('points')) {
    return PainterNavbarPages.painterPointsScreen;
  }
  if (currentLocationRoute.contains('profile')) {
    return PainterNavbarPages.painterProfileScreen;
  }
  return PainterNavbarPages.painterHomeScreen;
}

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

MerchantNavbarPages getMerchantNavbarPage(
    {required String currentLocationRoute}) {
  if (currentLocationRoute.contains('home')) {
    return MerchantNavbarPages.merchantHomeScreen;
  }
  if (currentLocationRoute.contains('stores')) {
    return MerchantNavbarPages.merchantStoresScreen;
  }
  if (currentLocationRoute.contains('notifications')) {
    return MerchantNavbarPages.merchantNotifications;
  }
  if (currentLocationRoute.contains('more')) {
    return MerchantNavbarPages.merchantMore;
  }
  return MerchantNavbarPages.merchantHomeScreen;
}

EcommerceNavbarPages getEcommerceNavbarPage(
    {required String currentLocationRoute}) {
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
    return EcommerceNavbarPages.eCommerceMyOrderScreen;
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
      path: '/:lang/about-us-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.aboutusScreen.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: AboutUsScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/faq-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.faqScreen.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: FaqScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),

    GoRoute(
      path: '/:lang/branch-screen/:branches',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.branchScreen.name,
      pageBuilder: (context, state) {
        Offset? begin = state.extra as Offset?;
        final lang = state.uri.queryParameters['lang'];
        final branchesJson = state.pathParameters['branches'];
        List branches = [];
        if (branchesJson != null) {
          try {
            branches = jsonDecode(Uri.decodeComponent(branchesJson)) as List;
          } catch (e) {
            debugPrint('Error decoding branches: $e');
          }
        }
        if (lang != null) {
          final locale = Locale(lang);
          context.setLocale(locale);
        }
        final animationController = AnimationController(
          vsync: ticker,
        );
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: BranchScreen(branches: branches,),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
        path: '/:lang/myOrder',
        parentNavigatorKey: _rootNavigatorKey,
        name: AppRoutes.myOrderScreen.name,
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
            child: const EcommerceOrderScreen(),
            animation: animationController,
            begin: begin ?? const Offset(1.0, 0.0),
          );
        },

    ),
    GoRoute(
      path: '/:lang/lang-setting-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.langSettingScreen.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: LangSettingScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/update-password',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.updatePassword.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: UpdatePasswordScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/personal-info',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.personalInfoScreen.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: const PersonalProfileScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/promo-code',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.promoCodeScreen.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: const PromoCodeScreen(),
          animation: animationController,
          begin: const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/book-mark',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.bookMark.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: const BookmarkScreen(),
          animation: animationController,
          begin: const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/contact-us',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.contactUs.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child:  ContactScreen(),
          animation: animationController,
          begin: const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/shipping-address',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.shippingAddress.name,
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
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: const ShippingAddressScreen(),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
    ),
    GoRoute(
      path: '/:lang/splash-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/:lang/notification-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.notification.name,
      builder: (context, state) => NotificationScreen(true),
    ),
    GoRoute(
      path: '/:lang/notification-details-screen/:title/:image/:contant/:date',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.notificationDetails.name,
      pageBuilder: (context, state) {
        Offset? begin = state.extra as Offset?;
        final lang = state.uri.queryParameters['lang'];
        final title = state.pathParameters['title'] ?? '';
        final image = state.pathParameters['image'] ?? '';
        final contant = state.pathParameters['contant'] ?? '';
        final date = state.pathParameters['date'] ?? '';

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
          child: SingleListDetailsScreen(
            date: date,
            title: title,
            image: image,
            contant: contant,
          ),
          animation: animationController,
          begin: begin ?? const Offset(1.0, 0.0),
        );
      },
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
      path: '/:lang/adminLogin',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.loginAdmin.name,
      pageBuilder: (context, state) {
        final lang = state.pathParameters['lang'];
        if (lang != null) {
          final locale = Locale(lang);
          context.setLocale(locale);
        }

        final animationController = AnimationController(
          vsync: ticker,
        );
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed ||
              status == AnimationStatus.dismissed) {
            animationController.dispose();
          }
        });
        return AppRouterTransitions.slideTransition(
          key: state.pageKey,
          child: const AdminLoginScreen(),
          animation: animationController,
          begin: const Offset(1.0, 0.0),
        );
      },
    ),
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
        },
    ),
    GoRoute(
      path: '/:lang/offline-screen',
      parentNavigatorKey: _rootNavigatorKey,
      name: AppRoutes.offlineScreen.name,
      builder: (context, state) => const OfflineScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MerchantMainScreen(
        // key: UniqueKey(),
        navbarPages: state.fullPath == null
            ? MerchantNavbarPages.merchantHomeScreen
            : getMerchantNavbarPage(currentLocationRoute: state.fullPath!),
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/merchantHome:lang',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.merchantHomeScreen.name,
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
            animationController.addStatusListener((status) {
              if (status == AnimationStatus.completed ||
                  status == AnimationStatus.dismissed) {
                animationController.dispose();
              }
            });
            return AppRouterTransitions.slideTransition(
              key: state.pageKey,
              child: const MerchantHomeScreen(),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
          routes: [
            GoRoute(
              path: 'viewStoresMerchant',
              parentNavigatorKey: _rootNavigatorKey,
              name: AppRoutes.merchantViewStoresScreen.name,
              pageBuilder: (context, state) {
              //  Offset? begin = state.extra as Offset?;
                final lang = state.pathParameters['lang'];
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
                  child: const MerchantStoresScreen(),
                  animation: animationController,
                  begin: const Offset(1.0, 0.0),
                );
              },
            ),
          ]
        ),
        GoRoute(
          path: '/:lang/storesMerchant',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.merchantStoresScreen.name,
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
              child: const MerchantStoresScreen(),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
          routes: [
            GoRoute(
              path: 'store-actions-merchant',
              parentNavigatorKey: _rootNavigatorKey,
              name: AppRoutes.storeActions.name,
              pageBuilder: (context, state) {
                final lang = state.uri.queryParameters['lang'];
                final Map<String, dynamic> data = jsonDecode(state.extra as String);
                final storeModel = StoreModel.fromJson(data['storeModel']);

                if (lang != null) {
                  final locale = Locale(lang);
                  context.setLocale(locale);
                }
                final animationController = AnimationController(
                  vsync: ticker,
                );
                animationController.addStatusListener((status) {
                  if (status == AnimationStatus.completed ||
                      status == AnimationStatus.dismissed) {
                    animationController.dispose();
                  }
                });
                return AppRouterTransitions.slideTransition(
                  key: state.pageKey,
                  child: MyStoreActionsScreen(storeModel: storeModel),
                  animation: animationController,
                  begin:  const Offset(1.0, 0.0),
                );
              },
              routes: [
                GoRoute(
                  path: 'store-available-products-merchant/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: AppRoutes.storeAvailableProducts.name,
                  pageBuilder: (context, state) {
                    Offset? begin = state.extra as Offset?;
                    final lang = state.uri.queryParameters['lang'];
                    final isInAvailable =
                        state.uri.queryParameters['isInAvailable'] ??
                            'true';
                    final id = int.parse(state.pathParameters['id'] ?? '0');

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
                      child: AvailableProductsScreen(
                        storeId: id,
                        isInAvailable:
                        isInAvailable.toLowerCase() == 'true',
                      ),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                ),
                GoRoute(
                  path: 'store-orders-merchant/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: AppRoutes.merchantStoreOrders.name,
                  pageBuilder: (context, state) {
                    Offset? begin = state.extra as Offset?;
                    final lang = state.uri.queryParameters['lang'];

                    final id = int.parse(state.pathParameters['id'] ?? '0');

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
                      child: MyOrdersScreen(
                        storeId: id,
                      ),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'order-details-merchant/:orderId/:storeId',
                      parentNavigatorKey: _rootNavigatorKey,
                      name: AppRoutes.orderDetails.name,
                      pageBuilder: (context, state) {
                        Offset? begin = state.extra as Offset?;
                        final lang = state.uri.queryParameters['lang'];

                        final orderId = int.parse(
                            state.pathParameters['orderId'] ?? '0');

                        final storeId = int.parse(
                            state.pathParameters['storeId'] ?? '0');

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
                          child: OrderDetailsScreen(
                            storeId: storeId,
                            orderId: orderId,
                          ),
                          animation: animationController,
                          begin: begin ?? const Offset(1.0, 0.0),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'edit-store-merchant',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: AppRoutes.editStore.name,
                  pageBuilder: (context, state) {
                    Offset? begin =
                    (state.extra as Map)['begin'] as Offset?;
                    final lang = state.uri.queryParameters['lang'];
                    final storeModel =
                    (state.extra as Map)['storeModel'] as StoreModel;

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
                      child: CreateEditStoreScreen(storeModel: storeModel),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'add-store-merchant',
              parentNavigatorKey: _rootNavigatorKey,
              name: AppRoutes.addStore.name,
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
                  child: const CreateEditStoreScreen(),
                  animation: animationController,
                  begin: begin ?? const Offset(1.0, 0.0),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/:lang/merchantNotifications',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.merchantNotifications.name,
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
            animationController.addStatusListener((status) {
              if (status == AnimationStatus.completed ||
                  status == AnimationStatus.dismissed) {
                animationController.dispose();
              }
            });
            return AppRouterTransitions.slideTransition(
              key: state.pageKey,
              child:  NotificationScreen(false),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
        ),
        GoRoute(
          path: '/:lang/merchantMore',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.merchantMore.name,
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
            animationController.addStatusListener((status) {
              if (status == AnimationStatus.completed ||
                  status == AnimationStatus.dismissed) {
                animationController.dispose();
              }
            });
            return AppRouterTransitions.slideTransition(
              key: state.pageKey,
              child: SettingsPageTwo(),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
        ),
      ],
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
            path: '/homeEcommerce:lang',
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
                path: 'single-product/:id',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.ecommerceSingleProductDetailScreen.name,
                pageBuilder: (context, state) {
                  // Offset? begin = state.extra as Offset?;
                  final idString = state.pathParameters['id'];
                  if (idString == null) {
                    throw Exception('Product ID is required');
                  }
                  final id = int.tryParse(idString);
                  if (id == null) {
                    throw Exception('Invalid Product ID');
                  }
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
                    child: EcommerceSingleProductDetailScreen(id),
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
                      routes: [
                        GoRoute(
                            path: 'ecommerce-webview/:url',
                            parentNavigatorKey: _rootNavigatorKey,
                            name: AppRoutes.eCommerceWebViewScreen.name,
                            pageBuilder: (context, state) {
                              Offset? begin = state.extra as Offset?;
                              final lang = state.uri.queryParameters['lang'];
                              final url = state.pathParameters['url'];
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
                                child: WebViewStack(url!),
                                animation: animationController,
                                begin: begin ?? const Offset(1.0, 0.0),
                              );
                            },
                        ),
                      ]
                    ),
                  ]
              ),
              GoRoute(
                path: 'color-trend',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.eCommerceColorTrendScreen.name,
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
                    child:const ColorTrendScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'get-inspired',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.eCommerceGetInspiredScreen.name,
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
                    child: InspiredScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'search_view/:id/:arrow',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.eCommerceSearchScreenView.name,
                pageBuilder: (context, state) {
                  // Offset? begin = state.extra as Offset?;
                  final arrowString = state.pathParameters['arrow'];  // The 'arrow' parameter as String?

                  final idString = state.pathParameters['id'];
                  if (idString == null) {
                    throw Exception('Product ID is required');
                  }
                  final id = int.tryParse(idString);
                  if (id == null) {
                    throw Exception('Invalid Product ID');
                  }
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
                    child: ECommerceSearchScreen(categoryId: id,viewArrow: (arrowString == "yes")? true: false ,),
                    animation: animationController,
                    begin:  const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'blog',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.blog.name,
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
                    child: BlogScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'blog-details/:title/:image/:contant/:date',
                    parentNavigatorKey: _rootNavigatorKey,
                    name: AppRoutes.blogDetails.name,
                    pageBuilder: (context, state) {
                      Offset? begin = state.extra as Offset?;
                      final lang = state.uri.queryParameters['lang'];
                      final title = state.pathParameters['title'] ?? '';
                      final image = state.pathParameters['image'] ?? '';
                      final contant = state.pathParameters['contant'] ?? '';
                      final date = state.pathParameters['date'] ?? '';

                      if (lang != null) {
                        final locale = Locale(lang);
                        context.setLocale(locale);
                      }
                      final animationController = AnimationController(
                        vsync: ticker,
                      );
                      animationController.addStatusListener((status) {
                        if (status == AnimationStatus.completed ||
                            status == AnimationStatus.dismissed) {
                          animationController.dispose();
                        }
                      });
                      return AppRouterTransitions.slideTransition(
                        key: state.pageKey,
                        child: BlogListDetailsScreen(
                          date: date,
                          title: title,
                          image: image,
                          contant: contant,
                        ),
                        animation: animationController,
                        begin: begin ?? const Offset(1.0, 0.0),
                      );
                    },
                  ),
                ]
              ),
            ]),
        GoRoute(
          path: '/:lang/testEcommerce',
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
            path: '/:lang/myOrderEcommerce',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceMyOrderScreen.name,
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
                child: const EcommerceOrderScreen(),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
          routes: [
            GoRoute(
              path: 'myOrder-ecommerce-details/:id',
              parentNavigatorKey: _rootNavigatorKey,
              name: AppRoutes.eCommerceMyOrderDetailsScreen.name,
              pageBuilder: (context, state) {
                // Offset? begin = state.extra as Offset?;
                final idString = state.pathParameters['id'];

                if (idString == null) {
                  throw Exception('Product ID is required');
                }
                final id = int.tryParse(idString);
                if (id == null) {
                  throw Exception('Invalid Product ID');
                }
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
                  child: EcommerceOrderDetailsScreen(id: id),
                  animation: animationController,
                  begin:  const Offset(1.0, 0.0),
                );
              },
            ),
          ]
        ),
          GoRoute(
            path: '/:lang/searchEcommerce/:id/:arrow',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.eCommerceSearchScreen.name,
            pageBuilder: (context, state) {
              final idString = state.pathParameters['id'];
              final arrowString = state.pathParameters['arrow'];  // The 'arrow' parameter as String?
              bool arrow = true;  // Default value

              if (arrowString != null) {
                arrow = arrowString.toLowerCase() == 'true';  // Convert 'true'/'false' to bool
              }
              if (idString == null) {
                throw Exception('Product ID is required');
              }
              final id = int.tryParse(idString);
              if (id == null) {
                throw Exception('Invalid Product ID');
              }
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
                child: ECommerceSearchScreen(categoryId: id, viewArrow: arrow ,),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
          ),
        GoRoute(
          path: '/:lang/moresEcommerce',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.eCommerceMoreScreen.name,
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
              child: SettingsPage(),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => LayoutPageScreen(
        // key: UniqueKey(),
        painterNavbarPages: state.fullPath == null
            ? PainterNavbarPages.painterHomeScreen
            : getPainterNavbarPage(currentLocationRoute: state.fullPath!),
        child: child,
      ),
      routes: [
        GoRoute(
            path: '/homePainter:lang',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.painterHomeScreen.name,
            pageBuilder: (context, state) =>
                NoTransitionPage(
                  child: HomeScreen(),
                ),
            routes: [
              GoRoute(
                path: 'painters-groups-view',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterViewMyGroupsScreen.name,
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
                    child:  GroupsPage(viewArrow: true,),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'painters-teams-view',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterViewTeamsScreen.name,
                pageBuilder: (context, state) {
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: const TeamsScreen(),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
            ]
        ),
        GoRoute(
            path: '/:lang/painters-groups',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.painterMyGroupsScreen.name,
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
                child: GroupsPage(viewArrow: false,),
                animation: animationController,
                begin: begin ?? const Offset(1.0, 0.0),
              );
            },
            routes: [
              GoRoute(
                path: 'painters-postDetailsScreen/:id/:groupName',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.postDetailsScreen.name,
                pageBuilder: (context, state) {
                  // Offset? begin = state.extra as Offset?;
                  final idString = state.pathParameters['id'];
                  final groupName = state.pathParameters['groupName'];

                  if (idString == null) {
                    throw Exception('Product ID is required');
                  }
                  final id = int.tryParse(idString);
                  if (id == null) {
                    throw Exception('Invalid Product ID');
                  }
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
                    child: PostDetailsScreen(socialGroupId: id, groupName: groupName!,),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'painters-addPostScreen/:id',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.addPostScreen.name,
                pageBuilder: (context, state) {
                  // Offset? begin = state.extra as Offset?;
                  final idString = state.pathParameters['id'];

                  if (idString == null) {
                    throw Exception('Product ID is required');
                  }
                  final id = int.tryParse(idString);
                  if (id == null) {
                    throw Exception('Invalid Product ID');
                  }
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
                    child: AddPostScreen(id: id),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },

              ),
            ]),
        GoRoute(
            path: '/:lang/painters-teams',
            parentNavigatorKey: _shellNavigatorKey,
            name: AppRoutes.painterTeamsScreen.name,
            pageBuilder: (context, state) {
              final lang = state.uri.queryParameters['lang'];
              if (lang != null) {
                final locale = Locale(lang);
                context.setLocale(locale);
              }
              final animationController = AnimationController(
                vsync: ticker,
              );
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed ||
                    status == AnimationStatus.dismissed) {
                  animationController.dispose();
                }
              });
              return AppRouterTransitions.slideTransition(
                key: state.pageKey,
                child: const TeamsScreen(),
                animation: animationController,
                begin: const Offset(1.0, 0.0),
              );
            },
            routes: [
              GoRoute(
                path: 'painters-rated-teams',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterRatedTeamsScreen.name,
                pageBuilder: (context, state) {
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: const RatedTeamScreen(),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'painters-member-teams/:id/:admin/:roles',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterMemberTeamsScreen.name,
                pageBuilder: (context, state) {
                  final idString = state.pathParameters['id'];
                  final adminString  = state.pathParameters['admin'];
                  final roles  = state.pathParameters['roles'];
                  if (adminString == null) {
                    throw Exception('Admin status is required');
                  }
                  final admin = adminString.toLowerCase() == 'true';
                  if (idString == null) {
                    throw Exception('Product ID is required');
                  }
                  final id = int.tryParse(idString);
                  if (id == null) {
                    throw Exception('Invalid Product ID');
                  }
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: TeamMembersScreen(id: id, admin: admin, roles: roles!,),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'painters-create-teams',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterCreateTeamsScreen.name,
                pageBuilder: (context, state) {
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: const CreateTeamScreen(),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
              GoRoute(
                path: 'painters-point-screen',
                parentNavigatorKey: _rootNavigatorKey,
                name: AppRoutes.painterPointsViewScreen.name,
                pageBuilder: (context, state) {
                  final lang = state.uri.queryParameters['lang'];
                  if (lang != null) {
                    final locale = Locale(lang);
                    context.setLocale(locale);
                  }
                  final animationController = AnimationController(
                    vsync: ticker,
                  );
                  animationController.addStatusListener((status) {
                    if (status == AnimationStatus.completed ||
                        status == AnimationStatus.dismissed) {
                      animationController.dispose();
                    }
                  });
                  return AppRouterTransitions.slideTransition(
                    key: state.pageKey,
                    child: PointsScreen(arrow: true,),
                    animation: animationController,
                    begin: const Offset(1.0, 0.0),
                  );
                },
              ),
            ]
        ),
        GoRoute(
          path: '/:lang/painters-points',
          name: AppRoutes.painterPointsScreen.name,
          parentNavigatorKey: _shellNavigatorKey,
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
              child: PointsScreen(arrow: false,),
              animation: animationController,
              begin: begin ?? const Offset(1.0, 0.0),
            );
          },
        ),
        GoRoute(
          path: '/painters-settings/:lang',
          parentNavigatorKey: _shellNavigatorKey,
          name: AppRoutes.painterProfileScreen.name,
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
              child: SettingsPageTwo(),
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
