import 'package:easy_localization/easy_localization.dart';
import 'package:orient/merchant/main/views/merchant_main_screen.dart';
import 'package:orient/modules/ecommerce/main_screen/main_screen.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/modules/teams/views/teams_screen.dart';
import '../general_services/app_config.service.dart';
import '../merchant/stores/views/my_stores_actions_screen.dart';
import '../models/request.model.dart';
import '../models/stores/store_model.dart';
import '../modules/authentication/views/login_screen.dart';
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
  merchantHome,
  splash,
  onboarding,
  login,
  storeActions,
  offlineScreen,
  qrcodeScreen,
  fingerprint,
  requests,
  notifications,
  more,
  requestsById,
  requestDetails,
  addRequest,
  stores,
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
  ecommerceSingleProductDetailScreen
}

const TestVSync ticker = TestVSync();

class TestVSync implements TickerProvider {
  const TestVSync();
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

enum NavbarPages { home, requests, fingerprint, notifications, more }

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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter goRouter(BuildContext context) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/${context.locale.languageCode}/ecommerce',
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
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          //main merchent screen
          builder: (context, state, child) =>const TeamsScreen(),//ECommerceMainScreen(),
          routes: [
            GoRoute(
              path: '/:lang',
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRoutes.home.name,
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
                  child: const HomeScreen(),
                  animation: animationController,
                  begin: begin ?? const Offset(1.0, 0.0),
                );
              },
              routes: [
                GoRoute(
                  path: 'personal-profile',
                  parentNavigatorKey: _shellNavigatorKey,
                  name: AppRoutes.personalProfile.name,
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
                      child: const PersonalProfileScreen(),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                ),
                GoRoute(
                  path: 'store-actions',
                  parentNavigatorKey: _shellNavigatorKey,
                  name: AppRoutes.storeActions.name,
                  pageBuilder: (context, state) {
                    Offset? begin = (state.extra
                        as Map<String, dynamic>)['offset'] as Offset?;

                    StoreModel storeModel = (state.extra
                        as Map<String, dynamic>)['storeModel'] as StoreModel;
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
                      child: MyStoreActionsScreen(
                        storeModel: storeModel,
                      ),
                      animation: animationController,
                      begin: begin ?? const Offset(1.0, 0.0),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
                path: '/:lang/requests/:type',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.requests.name,
                pageBuilder: (context, state) {
                  Offset? begin = state.extra as Offset?;
                  GetRequestsTypes? requestType =
                      RequestsServices.getRequestTypeFromString(
                          reqTypeString: state.pathParameters['type']);
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
                    child: RequestsScreen(
                      requestsType: requestType,
                    ),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'requests-calendar',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.requestsCalendar.name,
                    pageBuilder: (context, state) {
                      GetRequestsTypes? requestType =
                          RequestsServices.getRequestTypeFromString(
                              reqTypeString: state.pathParameters['type']);
                      List<RequestModel>? requests =
                          state.extra as List<RequestModel>;
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
                        child: RequestsCalendarScreen(
                          requestType: requestType,
                          requests: requests,
                        ),
                        animation: animationController,
                        begin: const Offset(1.0, 0.0),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'add-new-request',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.addRequest.name,
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
                        child: const AddRequestScreen(),
                        animation: animationController,
                        begin: const Offset(1.0, 0.0),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'requests-by-id/:id',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.requestsById.name,
                    pageBuilder: (context, state) {
                      Offset? begin = (state.extra
                          as Map<String, dynamic>)['offset'] as Offset?;
                      String? userId = (state.extra
                          as Map<String, dynamic>)['userId'] as String?;
                      String? id = state.pathParameters['id'];
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
                        child: RequestsByTypeIdScreen(
                          requestTypeId: id!,
                          employeeId: userId,
                        ),
                        animation: animationController,
                        begin: begin ?? const Offset(1.0, 0.0),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'request-details',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.requestDetails.name,
                    pageBuilder: (context, state) {
                      RequestModel? requestModel = state.extra as RequestModel?;
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
                        child: RequestDetailsScreen(
                          request: requestModel!,
                        ),
                        animation: animationController,
                        begin: const Offset(1.0, 0.0),
                      );
                    },
                  ),
                ]),
            GoRoute(
              path: '/:lang/fingerprint',
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRoutes.fingerprint.name,
              pageBuilder: (context, state) {
                Offset? begin =
                    (state.extra as Map<String, dynamic>)['offset'] as Offset?;
                String? employeeName = (state.extra
                    as Map<String, dynamic>)['employeeName'] as String?;
                String? employeeId = (state.extra
                    as Map<String, dynamic>)['employeeId'] as String?;
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
                  child: FingerprintScreen(
                    empId: employeeId,
                    empName: employeeName,
                  ),
                  animation: animationController,
                  begin: begin ?? const Offset(1.0, 0.0),
                );
              },
            ),
            GoRoute(
              path: '/:lang/notifications',
              parentNavigatorKey: _shellNavigatorKey,
              name: AppRoutes.notifications.name,
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
                  child: const NotificationsScreen(),
                  animation: animationController,
                  begin: begin ?? const Offset(1.0, 0.0),
                );
              },
            ),
            GoRoute(
                path: '/:lang/more',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.more.name,
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
                    child: const CompanyStructureInfoScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'company-tree',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.companyTree.name,
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
                        child: const CompanyStructureTreeScreen(),
                        animation: animationController,
                        begin: begin ?? const Offset(1.0, 0.0),
                      );
                    },
                  )
                ]),
            GoRoute(
                path: '/:lang/employees-list',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.employeesList.name,
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
                    child: const EmployeesListScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'employee-details',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.employeeDetails.name,
                    pageBuilder: (context, state) {
                      final employee = state.extra as EmployeeProfileModel?;
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
                        child: EmployeeDetailsScreen(
                          employee: employee,
                        ),
                        animation: animationController,
                        begin: const Offset(1.0, 0.0),
                      );
                    },
                  ),
                ]),
            GoRoute(
                path: '/:lang/payrolls-screen',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.payrollsList.name,
                pageBuilder: (context, state) {
                  Offset? begin = (state.extra
                      as Map<String, dynamic>)['offset'] as Offset?;
                  String? employeeName = (state.extra
                      as Map<String, dynamic>)['employeeName'] as String?;
                  String? employeeId = (state.extra
                      as Map<String, dynamic>)['employeeId'] as String?;
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
                    child: PayrollsListScreen(
                      empId: employeeId,
                      empName: employeeName,
                    ),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                      path: 'payroll-details',
                      parentNavigatorKey: _shellNavigatorKey,
                      name: AppRoutes.payrollDetails.name,
                      pageBuilder: (context, state) {
                        PayrollModel? payroll = state.extra as PayrollModel;
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
                          child: PayrollDetailsScreen(payroll: payroll),
                          animation: animationController,
                          begin: const Offset(1.0, 0.0),
                        );
                      }),
                ]),
            GoRoute(
                path: '/:lang/rewards-and-penalties-screen',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.rewardsAndPenalties.name,
                pageBuilder: (context, state) {
                  Offset? begin = (state.extra
                      as Map<String, dynamic>)['offset'] as Offset?;
                  String? employeeName = (state.extra
                      as Map<String, dynamic>)['employeeName'] as String?;
                  String? employeeId = (state.extra
                      as Map<String, dynamic>)['employeeId'] as String?;
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
                    child: RewardsAndPenaltiesScreen(
                      empId: employeeId,
                      empName: employeeName,
                    ),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                      path: 'add-rewards-and-penalties-screen',
                      parentNavigatorKey: _shellNavigatorKey,
                      name: AppRoutes.addRewardsAndPenalties.name,
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
                          child: const AddRewardAndPenaltyScreen(),
                          animation: animationController,
                          begin: const Offset(1.0, 0.0),
                        );
                      }),
                ]),
            GoRoute(
                path: '/:lang/ecommerce',
                parentNavigatorKey: _shellNavigatorKey,
                name: AppRoutes.eCommerceMainScreen.name,
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
                    child: ECommerceMainScreen(),
                    animation: animationController,
                    begin: begin ?? const Offset(1.0, 0.0),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'single-product',
                    parentNavigatorKey: _shellNavigatorKey,
                    name: AppRoutes.ecommerceSingleProductDetailScreen.name,
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
                        child: EcommerceSingleProductDetailScreen(),
                        animation: animationController,
                        begin: begin ?? const Offset(1.0, 0.0),
                      );
                    },
                  )
                ]
            ),
            // GoRoute(
            //   path: '/:lang/ecommerce/single-product',
            //   parentNavigatorKey: _shellNavigatorKey,
            //   name: AppRoutes.ecommerceSingleProductDetailScreen.name,
            //   pageBuilder: (context, state) {
            //     Offset? begin = state.extra as Offset?;
            //     final lang = state.uri.queryParameters['lang'];
            //     if (lang != null) {
            //       final locale = Locale(lang);
            //       context.setLocale(locale);
            //     }
            //     final animationController = AnimationController(
            //       vsync: ticker,
            //     );
            //     // Make sure to dispose the controller after the transition is complete
            //     animationController.addStatusListener((status) {
            //       if (status == AnimationStatus.completed ||
            //           status == AnimationStatus.dismissed) {
            //         animationController.dispose();
            //       }
            //     });
            //     return AppRouterTransitions.slideTransition(
            //       key: state.pageKey,
            //       child: EcommerceSingleProductDetailScreen(),
            //       animation: animationController,
            //       begin: begin ?? const Offset(1.0, 0.0),
            //     );
            //   },
            // ),
          ],
        ),
        // GoRoute(
        //     path: 'merchant-main',
        //     //  navigatorKey: _shellNavigatorKey,
        //     name: AppRoutes.merchantHome.name,
        //     pageBuilder: (context, state) {
        //       final animationController = AnimationController(
        //         vsync: ticker,
        //       );
        //       // Make sure to dispose the controller after the transition is complete
        //       animationController.addStatusListener((status) {
        //         if (status == AnimationStatus.completed ||
        //             status == AnimationStatus.dismissed) {
        //           animationController.dispose();
        //         }
        //       });
        //       return AppRouterTransitions.slideTransition(
        //         key: state.pageKey,
        //         child: MerchantMainScreen(),
        //         animation: animationController,
        //         begin: const Offset(1.0, 0.0),
        //       );
        //     }),
        //    routes: [],

        GoRoute(
          path: '/:lang/splash-screen',
          parentNavigatorKey: _rootNavigatorKey,
          name: AppRoutes.splash.name,
          builder: (context, state) => const SplashScreen(),
          //builder: (context, state) => MyStoresScreen(),
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
        // GoRoute(
        //   path: '/:lang/stores',
        //   parentNavigatorKey: _rootNavigatorKey,
        //   name: AppRoutes.stores.name,
        //   pageBuilder: (context, state) {
        //     Offset? begin = state.extra as Offset?;

        //     final animationController = AnimationController(
        //       vsync: ticker,
        //     );
        //     // Make sure to dispose the controller after the transition is complete
        //     animationController.addStatusListener((status) {
        //       if (status == AnimationStatus.completed ||
        //           status == AnimationStatus.dismissed) {
        //         animationController.dispose();
        //       }
        //     });
        //     return AppRouterTransitions.slideTransition(
        //       key: state.pageKey,
        //       child: const MyStoresScreen(),
        //       animation: animationController,
        //       begin: begin ?? const Offset(1.0, 0.0),
        //     );
        //   },
        // ),
      ],
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
